/* pdp8_vc8.c VC8(e) Graphics display Ian Schofield November 2016

   Copyright (c) 2018- Dr Ian S Schofield

   Permission is hereby granted, free of charge, to any person obtaining a
   copy of this software and associated documentation files (the "Software"),
   to deal in the Software without restriction, including without limitation
   the rights to use, copy, modify, merge, publish, distribute, sublicense,
   and/or sell copies of the Software, and to permit persons to whom the
   Software is furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
   ROBERT M SUPNIK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


   This device handler emulates the function of the VC8e option as specified
   in Doug Jones' outline: http://homepage.cs.uiowa.edu/~jones/pdp8/man/vc8e.html
   The original source for this was Phillip Budne's implementation in the current
   Simh primary version at http://simh.trailing-edge.com. I have tried to keep
   to the structure for a simh device as specified in
   http://simh.trailing-edge.com/docs/simh.pdf and I am sure that the experts
   will point out some glaring errors!
   The core functionality of this device is to generate a point plot
   display. The viewer is referred to sim_video.c which manages the
   display. The local display window is painted using SDL2 functions to
   plot the points in response to a DIXY instruction and the fade effect
   seen on a classic oscilloscope display due to the characteristics
   of the phosphor achieved by repeatedly reducing the luminance of all
   of the displayed points without the necessity or maintaining
   a list of points as in Phil's implementation. See Refresh() in sim_video.c

    The specific simh commands as as follows: (devicename vc8)

    show vc8				Display interface status
    set vc8 store/nostore   Enable storage display mode such that plotted points
							are not 'faded'.
							This emulates a Tektronix 610 XY display.
    set vc8 enable			This will activate the display and open a local
							SDL2 window.
							Once enabled, the display cannot be disabled.
    set vc8 erase			This command will erase the display.

    The local display size is configured in the source code as below
	(PIX_SCALE and arguments to display_init in init_x)

*/
#include <math.h>
#include <stdio.h>
#include <sys/types.h>
#include "pdp8_defs.h"
#include "sim_video.h"
#include "display/ws.h"
#include "display/display.h"


extern int32 int_req, int_enable, dev_done, stop_inst;
static void init_x(DEVICE *);
static void add_point();
static void init_sock();


int32 vc8_err = 0;                                      /* error flag */
int32 vc8_stopioe = 0;                                  /* stop on error */
int32 vc8_xreg;
int32 vc8_yreg;
int32 vc8_ctrl;

static int initOK=0;
static int vc8_erase;

#define VC8_INTEN 1
#define VC8_DONE 2048  // MSB
#ifndef PIX_SIZE
#define PIX_SIZE 1
#endif

#define UNIT_V_VC8   (UNIT_V_UF)

#define VC8_MODE       (1u << UNIT_V_VC8)
#define VC8_SOCK       (2u << UNIT_V_VC8)
#define VC8_X11        (4u << UNIT_V_VC8)
#define VC8_CTRL       (6u << UNIT_V_VC8)
#define VC8_MODE_STR   (1u << UNIT_V_VC8)
#define VC8_MODE_NRM   0
#define VC8_MODE_LCL   (4u << UNIT_V_VC8)
#define VC8_MODE_NOLCL 0
#define VC8_MODE_ERASE 0


/* select a resolution */
#ifndef PIX_SCALE
#define PIX_SCALE RES_FULL
#endif

/* PIXELS gives the screen dimension in displayed pixels */
#define PIXELS       1024/PIX_SIZE


int32 vc8 (int32 IR, int32 AC);
t_stat vc8_svc (UNIT *uptr);
t_stat vc8_reset (DEVICE *dptr);
t_stat vc8_set_mode(UNIT *uptr, int32 val, const char *cptr, void *desc);
t_stat vc8_erase_screen(UNIT *uptr, int32 val, const char *cptr, void *desc);

/* VC8 data structures

   vc8_dev      VC8 device descriptor
   vc8_unit     VC8 unit descriptor
   vc8_reg      VC8 register list
*/

DIB vc8_dib = { DEV_VC8, 1, { &vc8 } };

UNIT vc8_unit =  { UDATA (&vc8_svc, UNIT_IDLE , 0), 15000 };

REG vc8_reg[] =
{
    { ORDATA (XREG, vc8_xreg, 12) },
    { ORDATA (YREG, vc8_yreg, 12) },
    { ORDATA (CTRL, vc8_ctrl, 12) },
    { FLDATA (ERR, vc8_err, 0) },
    { FLDATA (DONE, dev_done, INT_V_VC8) },
    { FLDATA (ENABLE, int_enable, INT_V_VC8) },
    { FLDATA (INT, int_req, INT_V_VC8) },
    { DRDATA (POS, vc8_unit.pos, T_ADDR_W), PV_LEFT },
    { DRDATA (TIME, vc8_unit.wait, 24), PV_LEFT },
    { FLDATA (STOP_IOE, vc8_stopioe, 0) },
    { ORDATA (DEVNUM, vc8_dib.dev, 6), REG_HRO },
    { NULL }
};

MTAB vc8_mod[] = {
    { VC8_MODE, VC8_MODE_NRM,  "NoStore",  "NOSTORE",  &vc8_set_mode },
    { VC8_MODE, VC8_MODE_STR,  "Store",  "STORE",  &vc8_set_mode },
    { VC8_CTRL, VC8_MODE_ERASE,  "Erase",  "ERASE",  &vc8_erase_screen },
    { MTAB_XTD|MTAB_VDV, 0, "DEVNO", "DEVNO", &set_dev, &show_dev, NULL },
    { 0 }
};

DEVICE vc8_dev =
{
    "VC8", &vc8_unit, vc8_reg, vc8_mod,
    1, 10, 31, 1, 8, 8,
    NULL, NULL, &vc8_reset,
    NULL, NULL, NULL,
    &vc8_dib, DEV_DISABLE | DEV_DIS
};

/* IOT routine */

int32 vc8 (int32 IR, int32 AC)
{
    UNIT *uptr=vc8_dev.units;

    switch (IR & 07)                                    /* decode IR<9:11> */
    {

    case 0:                                             /* DISD */
        dev_done = dev_done & ~INT_VC8;                 /* clear flag */
        //int_req = int_req & ~INT_VC8;                   /* clear int req */
        vc8_ctrl = 0;
        return AC;

    case 1:                                             /* DICD */
        dev_done = dev_done & ~INT_VC8;                 /* clear flag */
        //int_req = int_req & ~INT_VC8;                 /* clear int req */
        vc8_ctrl &= ~VC8_DONE;
        return AC;

    case 2:                                             /* DISD */
        return (dev_done & INT_VC8)? IOT_SKP + AC: AC;

    case 3:                                             /* DILX */
        vc8_xreg = (AC & 01777) ^ 01000;
        dev_done |= INT_VC8;
        vc8_ctrl |= VC8_DONE;
        return AC;

    case 4:                                             /* DILY */
        vc8_yreg = (AC & 01777) ^ 01000;
        dev_done |= INT_VC8;
        vc8_ctrl |= VC8_DONE;
        return AC;

    case 6:                                             /* DILE*/
        vc8_ctrl = AC & ~VC8_DONE & 067;
        vc8_ctrl |= (uptr->flags & VC8_MODE_STR)?020:0;                 /* In store mode */
        if ((AC & 010) && (uptr->flags & VC8_MODE_STR)) vc8_erase++;    /* Initiate erase cycle */
        return AC & 01000;

    case 5:                                             /* DIXY */
        add_point();
        return AC;

    case 7:                                             /* DIRE */
        AC = vc8_ctrl;
        return AC;
    }                                                   /* end switch */
    return 0;
}

/* Unit service called at 33 Hz. */

extern int32 SR;
extern int nostore;

t_stat vc8_svc (UNIT *uptr)
{

    if (initOK)
    {
        if (vc8_erase) {
            vid_erase_win();
            vc8_erase=0;
        }
    }
    display_age(0,0);
    SR = spacewar_switches;			  /* If VC8 active, set SR from SpaceWar switches */
    sim_activate_after (uptr, 30000);             /* reactivate unit after 30mS */

    return SCPE_OK;
}

/* Reset routine */

t_stat vc8_reset (DEVICE *dptr)
{
    int32 t;

    vc8_unit.buf = 0;
    vc8_unit.u3=0;
    dev_done = dev_done & ~INT_VC8;                          /* clear done, int */
    int_req = int_req & ~INT_VC8;
    int_enable = int_enable & ~INT_VC8;                      /* clear enable */
    vc8_err = (vc8_unit.flags & UNIT_ATT) == 0;
    nostore=0;
    if (!sim_is_running && !(dptr->flags & DEV_DIS))         /* RESET (not CAF)? */
    {
        init_x(dptr);
        t = sim_rtcn_init (vc8_unit.wait, TMR_CLK);
        sim_activate (&vc8_unit, t);                         /* activate unit */
        return SCPE_OK;
    }
    if (!sim_is_running && (dptr->flags & DEV_DIS))          /* RESET (not CAF)? */
    {
        ws_shutdown();
        display_reset();
        initOK=0;
    }

    return SCPE_OK;
}


t_stat vc8_set_mode(UNIT *uptr, int32 val, const char *cptr, void *desc)
{
    vc8_unit.flags |= val;
    nostore=val & VC8_MODE_STR;
    return SCPE_OK;
}

/* Erase screen from simh prompt */

t_stat vc8_erase_screen(UNIT *uptr, int32 val, const char *cptr, void *desc)
{
    return vid_erase_win();
}


static void init_x(DEVICE *dptr)
{
    if (initOK)
        return;
    display_init(DIS_VR17, PIX_SCALE, dptr);

    initOK=1;
}


/*********************************/
/* Display Device Implementation */
/*********************************/


static void add_point()
{
    int x,y;

    /* recall that x and y values are signed;
       this converts them to unsigned values, origin in lower left */
    x = (vc8_xreg & 01777);
    y = (vc8_yreg & 01777);

    /* scale x and y to the displayed number of pixels */
//  x = x / PIX_SCALE;
//  y = y / PIX_SCALE;

    /* x and y are now in the range 0..(PIXELS-1) */

    if (initOK)
    {
        display_point(x, y, 7, 0);
    }
}


