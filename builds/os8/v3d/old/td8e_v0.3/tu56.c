/* File: tu56.c
   Author: Gerold Pauler, 10711 Berlin, Germany
   Date: Nov 21, 2003
   Language: C (UNIX)
   Purpose: DEC TD8 TU56 panel simulator, using X and Xt widgets

   Based on the pdp8 emulator of
   Douglas Jones, Dept. of Comp. Sci., U. of Iowa, Iowa City, IA 52242.

   and on the description in the
   pdp8/e pdp8/f pdp8/m Maintenance Man. Digital Equipment Corporation, 1972.
   Small Computer Handbook Digital Equipment Corporation, 1966/67, 1967 or 1973.
   TD8E DECtape Diagnostic Digital Equipment Corporation, 1971,72.
*/

#include <stdio.h>
#include <strings.h>

#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Core.h>
#include <X11/Shell.h>
#define XK_MISCELLANY
#include <X11/keysymdef.h>

#include "realtime.h"
#include "bus.h"


#ifdef TD8E0
#define TU56_power	tu560_power
#define TU56_init	tu560_init

#define wtm_switch	td8e0_wtm
#define tape_name	td8e0_name
#define current_line	td8e0_cline
#define TAPE_wrt_lck	td8e0_wlock
#define TAPE_select	td8e0_select
#define command_register	td8e0_cr
#define data_register		td8e0_dr
#endif

#ifdef TD8E1
#define TU56_power	tu561_power
#define TU56_init	tu561_init

#define wtm_switch	td8e1_wtm
#define tape_name	td8e1_name
#define current_line	td8e1_cline
#define TAPE_wrt_lck	td8e1_wlock
#define TAPE_select	td8e1_select
#define command_register	td8e1_cr
#define data_register		td8e1_dr
#endif

#ifdef TD8E2
#define TU56_power	tu562_power
#define TU56_init	tu562_init

#define wtm_switch	td8e2_wtm
#define tape_name	td8e2_name
#define current_line	td8e2_cline
#define TAPE_wrt_lck	td8e2_wlock
#define TAPE_select	td8e2_select
#define command_register	td8e2_cr
#define data_register		td8e2_dr
#endif

#ifdef TD8E3
#define TU56_power	tu563_power
#define TU56_init	tu563_init

#define wtm_switch	td8e3_wtm
#define tape_name	td8e3_name
#define current_line	td8e3_cline
#define TAPE_wrt_lck	td8e3_wlock
#define TAPE_select	td8e3_select
#define command_register	td8e3_cr
#define data_register		td8e3_dr
#endif

extern int wtm_switch;
extern char tape_name[2][NAME_LENGTH];
extern long current_line[2];
extern int TAPE_wrt_lck[2];
extern int TAPE_select;
extern int command_register;
extern int data_register;


/***************************/
/* User controlled options */
/***************************/

/* default frequency for console display update and X-events polling */
#define tu56cons_interval (300 * millisecond + 1)

/* height of console, in pixels, divisible by 30; width is 2.1 times this */
#define PDP8height 300
#define TU56height ( (PDP8height / 5) * 6 )


/**************************/
/* Window data structures */
/**************************/

static Widget	tu56panelshell;  /* a framework for the TU56 panel */
static Widget	tu56panel;       /* the TU56 panel */


/*******************************/
/* tools for making tu56panel */
/*******************************/

static Display*	dpy;		/* its display */
static int	scr;		/* its screen */
static Colormap	cmap;		/* its colormap */

#define bright 65535		/* fully on color value */
static XColor grey;		/* color for for grey */
static XColor darkgrey;		/* color for for darker shade of grey */
static XColor goldenrod;	/* .. for goldenrod (when in doubt, grey) */
static XColor terracotta;	/* .. for terracotta (in doubt, dark grey) */
static XColor olivgreen;	/* .. for olivgreen (in doubt, dark grey) */

/* 16 by 16 bitmap data for dark shades */
static char dark_bits[] = {
   0x55, 0x55, 0xaa, 0xaa, 0x55, 0x55, 0xaa, 0xaa, 0x55, 0x55, 0xaa, 0xaa,
   0x55, 0x55, 0xaa, 0xaa, 0x55, 0x55, 0xaa, 0xaa, 0x55, 0x55, 0xaa, 0xaa,
   0x55, 0x55, 0xaa, 0xaa, 0x55, 0x55, 0xaa, 0xaa};
static Pixmap dark_bitmap;	/* used to darken shades (uses darkbits) */

/* fonts */
static XFontStruct* headinfo;	/* info about headline font */
static XFontStruct* tinyinfo;	/* info about tiny font used to label things */
static XFontStruct* subinfo;	/* info about font for subheadline */
static XFontStruct* helpinfo;	/* info about font used for help messages */

/* all GC's have black backgrounds */
static GC whiteGC;		/* gc with white foreground, tinyfont */
static GC headGC;		/* gc with big headline font */
static GC subGC;		/* gc with modest subheadline font */
static GC greyGC;		/* gc with grey foreground, tinyfont */
static GC darkgreyGC;		/* gc with dark grey foreground, tinyfont */
static GC blackGC;		/* gc with black foreground */
static GC goldGC;		/* gc with goldenrod foreground */
static GC terraGC;		/* gc with terracotta foreground */
static GC darkterraGC;		/* gc with dark terracotta foreground */
static GC olivGC;		/* gc with dark olivgreen foreground */
static GC darkolivGC;		/* gc with dark olivgreen foreground */
static GC helpGC;		/* gc used for help messages */

static changewtm();
static changeregs();

/*****************************************/
/* tools for filling a window with boxes */
/*****************************************/

struct box_rec {
	int x,y;	  /* where to put box (upper left corner) */
	int width,height; /* how big is rectangle */
	GC boxGC;	  /* GC to use */
	char rule;	  /* drawing rule 0 for outline, 1 for solid */
	char* label;	  /* character string to use as label */
	GC labGC;	  /* GC to use for label (if label != NULL) */
	XFontStruct* labinfo;	/* data about font (if label != NULL) */
	int lablen;	  /* label length (if label != NULL) */
	int labx,laby;	  /* coordinates of label (if label != NULL) */
	void (* press)(); /* hook to call when mouse click in box */
			  /* pointer to box is passed as param to hook */
	char* help;	  /* help message to display for box */
	int state;	  /* state of box */
	struct box_rec* next;    /* pointer to next box in console */
	struct box_rec* sub;     /* pointer to subsidiary boxes */
	struct box_rec* replot;  /* pointer to box to replot (when needed) */
};
#define NOBOX (struct box_rec *)NULL
#define blankbox 0
#define linebox 1
#define fillbox 2
#define linefillbox 3
#define circlebox 4

static boxshow( box )
struct box_rec* box;
{
	struct box_rec* b;

	b = box->sub;

	if (box->rule == linebox) { /* outline */
		while (b != NOBOX) { /* put outline over sub boxes */
			boxshow( b );
			b = b->next;
		}
		XDrawRectangle( dpy, XtWindow(tu56panel), box->boxGC,
				box->x, box->y, box->width-1, box->height-1 );
	} else if (box->rule == fillbox) { /* solid */
		XFillRectangle( dpy, XtWindow(tu56panel), box->boxGC,
				box->x, box->y, box->width, box->height );
		while (b != NOBOX) { /* put sub boxes over filled region */
			boxshow( b );
			b = b->next;
		}
	} else if (box->rule == linefillbox) { /* solid outlined box */
		XFillRectangle( dpy, XtWindow(tu56panel), box->boxGC,
				box->x, box->y, box->width, box->height );
		while (b != NOBOX) { /* put outline over sub boxes */
			boxshow( b );
			b = b->next;
		}
		XDrawRectangle( dpy, XtWindow(tu56panel), whiteGC,
				box->x, box->y, box->width-1, box->height-1 );
	} else if (box->rule == circlebox) { /* lightbulb and reel */
		XFillArc( dpy, XtWindow(tu56panel), box->boxGC,
				box->x, box->y, box->width, box->height,
				0,360*64 );
		while (b != NOBOX) { /* put outline over sub boxes */
			boxshow( b );
			b = b->next;
		}
	} else {
		while (b != NOBOX) { /* put outline over sub boxes */
			boxshow( b );
			b = b->next;
		}
	}
	if (box->label != NULL) {
		XDrawString( dpy, XtWindow(tu56panel), box->labGC,
			     box->labx, box->laby, box->label, box->lablen);
	}
}

/* box records globally known to boxpress so it can implement help requests */
static struct box_rec* helpbox;
static struct box_rec* helpok;

static showhelpmsg( m )
char * m;
/* make a help message appear, with OK button armed to make it go away */
{
	helpbox->label = m;
	helpbox->lablen = strlen(helpbox->label);
	helpbox->rule = linefillbox;
	helpbox->sub = helpok;
	boxshow( helpbox );
}

static boxpress( x, y, button, box )
int x, y;
unsigned int button;
struct box_rec* box;
{
	struct box_rec* child;

	/* a mouse button was pressed in box */
	/* step 1:  was it in a sub-box of box? */
	child = box->sub;
	while (child != NOBOX) {
		if (  (x > child->x) && (x < (child->x + child->width) )
		   && (y > child->y) && (y < (child->y + child->height) )
		   ) {
			boxpress( x, y, button, child );
			return;
		}
		child = child->next;
	}

	/* step 2:  if not in a sub-box, */
	if (button == Button1) { /* take action */
		(* box->press)(box);
	} else if (box->help != NULL) { /* offer help */
		showhelpmsg( box->help );
	}
}

static struct box_rec* makebox( b )
struct box_rec* b;
/* copy from a prototype box to the real thing; used because many boxes
   can frequently be copied from one prototype, with only a few changed
   parameters for each
*/
{
	struct box_rec* n;
	XCharStruct overall;
	int dir, up, down;
	n = (struct box_rec*)malloc( sizeof(struct box_rec) );
	n->x = b->x;
	n->y = b->y;
	n->width = b->width;
	n->height = b->height;
	n->boxGC = b->boxGC;
	n->label = b->label;
	n->lablen = b->lablen;
	n->labx = b->labx;
	n->laby = b->laby;
	n->labGC = b->labGC;
	n->labinfo = b->labinfo;
	if (b->label != NULL) {
		if (b->lablen==0) {
			n->lablen = strlen(b->label);
		}
		if ((b->labx==0)||(b->laby==0)) {
			XTextExtents( n->labinfo, n->label, n->lablen,
				     &dir, &up, &down, &overall );
		}
		if (b->labx==0) {
			int w = overall.rbearing - overall.lbearing;
			n->labx = b->x+(b->width/2)-(w/2)-overall.lbearing;
		}
		if (b->laby==0) {
			int h = overall.ascent + overall.descent;
			n->laby = b->y+(b->height/2)+(h/2)-overall.descent;
		}
	}
	n->rule = b->rule;
	n->press = b->press;
	n->help = b->help;
	n->state = b->state;
	n->next = b->next;
	n->sub = b->sub;
	return n;
}


/******************************************/
/* button press event handling procedures */
/******************************************/

static void (* keypress)() = NULL; /* hook to call for keypress (char param) */

static void backpress(b)
struct box_rec* b;
/* mouseclick in background, do nothing */
{
}

/* box records globally known to logopress so special panel can be toggled */
static struct box_rec* logobox;  /* the box holding tu56 or td8e controls */
static struct box_rec* td8ebox;  /* the box holding the td8e wtm switch */
static struct box_rec* panelbox; /* the box holding the tu56 panel */

static struct box_rec* wtm_box;  /* wtm switch for td8 on the alternate panel*/
static struct box_rec* cr_box;   /* command reg of td8 on the alternate panel*/
static struct box_rec* dr_box;   /* data reg of td8 on the alternate panel*/

static char cr_str[] = "CR 0000";
static char dr_str[] = "DR 0000";

static struct box_rec* reelbox;  /* the box holding tu56 */
static struct box_rec* leftbox;  /* the box holding left tu56 */
static struct box_rec* rightbox; /* the box holding right tu56 */

static struct box_rec* lreel[2];   /* the box holding left reel of tu56 */
static struct box_rec* rreel[2];   /* the box holding right reel of tu56 */

static struct box_rec* ltape[2];   /* the box holding left tape of tu56 */
static struct box_rec* rtape[2];   /* the box holding right tape of tu56 */

static struct box_rec* wrtbulb[2]; /* the box holding the write enable light */
static struct box_rec* wrtlck[2];  /* the box holding the write lock switch */

static struct box_rec* selbulb[2]; /* the box holding the remote select light */

/***********************************************/
/* tools for making toggle switches from boxes */
/***********************************************/

static int toggleswitch(b, nstates)
struct box_rec* b;
int nstates;
/* change state of switch with top-level box b */
{
	struct box_rec* sup = b->replot;
	struct box_rec* sub = sup->sub;
	if (sup->y == sub->y) { /* switch is up, put down */
		if (3 == nstates) {
			sub->y = sup->y + 2 * sub->height;
			if (logobox->sub == panelbox) {
				boxshow(sup);
			}
			return 2;
		}
		else {
			sub->y = sup->y + 4 * sub->height;
			if (logobox->sub == panelbox) {
				boxshow(sup);
			}
			return 1;
		}
	}
	else if ((sup->y + 3 * sub->height) > sub->y) { /* switch is neutral */
		sub->y = sup->y + 4 * sub->height;
		if (logobox->sub == panelbox) {
			boxshow(sup);
		}
		return 1;
	}
	else { /* switch is down, put up */
		sub->y = sup->y;
		if (logobox->sub == panelbox) {
			boxshow(sup);
		}
		return 0;
	}
}

static struct box_rec* makeswitch( b, state )
struct box_rec* b;
int state;
/* called to make a switch from prototype b with initial state 0 or 1 */
{
	struct box_rec* n = makebox( b );
	struct box_rec* sub = makebox( b );

	/* n will be the box outlining the switch, sub will be the toggle */
	sub->height = b->height/5;
	if (state == 0) { /* switch down */
		sub->y = b->y + 4 * sub->height;
	}
	else if (state == 2) { /* switch neutral */
		sub->y = b->y + 2 * sub->height;
	}
	sub->boxGC = b->labGC;
	sub->next = NOBOX;
	sub->sub = NOBOX;
	sub->replot = n;
	n->sub = sub;
	n->replot = n;

	return n;
}

static void wtmpress(b)
struct box_rec* b;
/* mouse click in button requesting toggle of wtm switch */
{
	if ( wtm_switch == 0 ) {
		wtm_switch = 1;
		wtm_box->boxGC = terraGC;
	}
	else { /* wtm_switch == 1 */
		wtm_switch = 0;
		wtm_box->boxGC = darkgreyGC;
	}
	boxshow( wtm_box );
}

static changewtm()
{
	if ( wtm_switch == 0 ) {
		wtm_box->boxGC = darkgreyGC;
	}
	else { /* wtm_switch == 1 */
		wtm_box->boxGC = terraGC;
	}

	sprintf( cr_str, "CR %4.4o", command_register );
	sprintf( dr_str, "DR %4.4o", data_register );
	
	if (logobox->sub == td8ebox) {
		boxshow( wtm_box );
		boxshow( cr_box );
		boxshow( dr_box );
	}
}

#define i (PDP8height/10)     /* top and side indent margin */

static changeregs()
{
	int tape_dia[2];
	int rdia[2], ldia[2];
	int n;

	for ( n=0; 2 > n; n++ ) {
		tape_dia[n] = (int)( (long)(current_line[n] * i) / 1120000L );

		if ( i <= tape_dia[n] ) {
			tape_dia[n] = i;
		}
		if ( 0 >= tape_dia[n] ) {
			tape_dia[n] = 0;
		}
		
		if ( '\0' == tape_name[n][0] ) {
			rdia[n] = 3*i;
			ldia[n] = 3*i;
		}
		else {
			rdia[n] = 3*i + 2*tape_dia[n];
			ldia[n] = 5*i - 2*tape_dia[n];
		}

		if ( ldia[n] != ltape[n]->width ) {
			rtape[n]->x = rtape[n]->x +
					(rtape[n]->width - rdia[n]) / 2;
			rtape[n]->y = rtape[n]->y +
					(rtape[n]->height - rdia[n]) / 2;
			rtape[n]->width = rdia[n];
			rtape[n]->height = rdia[n];
			ltape[n]->x = ltape[n]->x +
					(ltape[n]->width - ldia[n]) / 2;
			ltape[n]->y = ltape[n]->y +
					(ltape[n]->height - ldia[n]) / 2;
			ltape[n]->width = ldia[n];
			ltape[n]->height = ldia[n];
			boxshow(rreel[n]);
			boxshow(lreel[n]);
		}

		if ((0 == TAPE_wrt_lck[n]) && (wrtbulb[n]->boxGC == blackGC)) {
			wrtbulb[n]->boxGC = goldGC;
			toggleswitch(wrtlck[n], 2);
			if (logobox->sub == panelbox) {
				boxshow(wrtbulb[n]);
			}
		}
		if ((1 == TAPE_wrt_lck[n]) && (wrtbulb[n]->boxGC == goldGC)) {
			wrtbulb[n]->boxGC = blackGC;
			toggleswitch(wrtlck[n], 2);
			if (logobox->sub == panelbox) {
				boxshow(wrtbulb[n]);
			}
		}

		if ((n == TAPE_select) && (selbulb[n]->boxGC == blackGC)) {
			selbulb[n]->sub->next->boxGC = goldGC;
			selbulb[n]->sub->boxGC = goldGC;
			selbulb[n]->boxGC = goldGC;
			if (logobox->sub == panelbox) {
				boxshow(selbulb[n]);
			}
		}
		if ((n != TAPE_select) && (selbulb[n]->boxGC == goldGC)) {
			selbulb[n]->sub->next->boxGC = blackGC;
			selbulb[n]->sub->boxGC = blackGC;
			selbulb[n]->boxGC = blackGC;
			if (logobox->sub == panelbox) {
				boxshow(selbulb[n]);
			}
		}
	}
}
#undef i

static void reelpress(b)
struct box_rec* b;
{
	char msg[2 * NAME_LENGTH];

	sprintf( msg,
#ifdef TD8E0
	"mounted files on DTA0: %s   - DTA1: %s"
#endif
#ifdef TD8E1
	"mounted files on DTA2: %s   - DTA3: %s"
#endif
#ifdef TD8E2
	"mounted files on DTA4: %s   - DTA5: %s"
#endif
#ifdef TD8E3
	"mounted files on DTA6: %s   - DTA7: %s"
#endif
		, tape_name[0], tape_name[1] );
	showhelpmsg( msg );
}

static void helppress(b)
struct box_rec* b;
{
	showhelpmsg( b->help );
}

static void helpokpress(b)
/* mouseclick on ok button in help message */
struct box_rec* b;
{
	/* the following makes the help message box go away */
	/* this undoes the work done by showhelp */
	helpbox->rule = fillbox;
	helpbox->label = NULL;
	helpbox->sub = NOBOX;
	boxshow(helpbox);
	helpbox->rule = blankbox;
	boxshow(reelbox);
}


static void logopress(b)
struct box_rec* b;
/* toggle between TD8E wtm switch and TU56 control panel */
{
	if (logobox->sub == td8ebox) {
		logobox->sub = panelbox;
	} else {
		logobox->sub = td8ebox;
	}
	boxshow( logobox );
}

static void lwrtlckpress(b)
struct box_rec* b;
/* toggle between write enable and write lock */
{
	TAPE_wrt_lck[0] = toggleswitch(b, 2);
	if ( 0 == TAPE_wrt_lck[0] ) {
		wrtbulb[0]->boxGC = goldGC;
	}
	else {
		wrtbulb[0]->boxGC = blackGC;
	}
	boxshow(wrtbulb[0]);
	changeregs();
}

static void rwrtlckpress(b)
struct box_rec* b;
/* toggle between write enable and write lock */
{
	TAPE_wrt_lck[1] = toggleswitch(b, 2);
	if ( 0 == TAPE_wrt_lck[1] ) {
		wrtbulb[1]->boxGC = goldGC;
	}
	else {
		wrtbulb[1]->boxGC = blackGC;
	}
	boxshow(wrtbulb[1]);
	changeregs();
}

#if 0
/*
 * not implemented yet
 */
static int tape_dir[2];
static int tape_rem[2];

static void ldirpress(b)
struct box_rec* b;
/* toggle between forward and backward */
{
	tape_dir[0] = toggleswitch(b, 3);
	changeregs();
}

static void rdirpress(b)
struct box_rec* b;
/* toggle between forward and backward */
{
	tape_dir[1] = toggleswitch(b, 3);
	changeregs();
}

static void lrempress(b)
struct box_rec* b;
/* toggle between remote, off and local */
{
	tape_rem[0] = toggleswitch(b, 3);
	changeregs();
}

static void rrempress(b)
struct box_rec* b;
/* toggle between remote, off and local */
{
	tape_rem[1] = toggleswitch(b, 3);
	changeregs();
}
#endif


/*****************************************************/
/* code to build the actual TU56 control panel image */
/*****************************************************/

/* the top-level box on the screen */
static struct box_rec* boxlist;

static makeboxes()
#define H TU56height /* full TU56 height */
#define h PDP8height /* full control panel height */
#define i (h/10)     /* top and side indent margin */
#define p (h/20)     /* partial margin indent */
#define c (h/30)     /* caption bar width */
#define t (h/80)     /* thin line width */
#define s (h/15)     /* switch width */
{
	int x;
	struct box_rec b;
	struct box_rec* sublist;
	struct box_rec* tmplist;
	struct box_rec* rmtlist;

	/* box structures use indenting to show hierarchical relationship */

	b.x = i-t; b.y = i-t;
	b.width = 2*h-i+2*t; b.height = 3*i;
	b.boxGC = blackGC;
	b.label = NULL;
	b.lablen = 0;
	b.labx = 0;
	b.laby = 0;
	b.rule = fillbox;
	b.press = backpress;
	b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
	b.next = NOBOX; b.sub = NOBOX;
	boxlist = makebox(&b); /* the logo bar across the top */
	{
		sublist = NOBOX;
		b.label = NULL;
		b.labGC = subGC;
		b.labinfo = subinfo;

		b.x = i-t + s; b.y = i;
		b.width = 4*s; b.height = s-t;
		b.rule = linefillbox;
		b.boxGC = darkgreyGC;
		b.label = cr_str;
		b.press = backpress;
		b.help =
"shows contents of command reg";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);	/* add wtm_switch to bar */
		cr_box = sublist;

		b.x = i-t + 5*s + s/2 ; b.y = i;
		b.width = 4*s; b.height = s-t;
		b.rule = linefillbox;
		b.boxGC = darkgreyGC;
		b.label = dr_str;
		b.press = backpress;
		b.help =
"shows contents of data reg";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);	/* add wtm_switch to bar */
		dr_box = sublist;

		b.x = 2+12*s; b.y = i;
		b.width = 2*s+s/2; b.height = s-t;
		b.rule = linefillbox;
		b.boxGC = darkgreyGC;
		b.label = "WTM";
		b.press = wtmpress;
		b.help =
"click here for to write time and mark tracks on tape";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);	/* add wtm_switch to bar */
		wtm_box = sublist;

		b.x = 2*h-s; b.y = i;
		b.width = s; b.height = s-t;
		b.label = "OK";
		b.press = logopress;
		b.state = 0;
		b.help =
"click the left button here to restore the TU56 panel";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);

		b.x = 2*h-8*s; b.y = i;
		b.width = 2*s+s/2; b.height = s-t;
		b.rule = linefillbox;
		b.boxGC = darkgreyGC;
		b.label = "AUTHOR";
		b.press = helppress;
		b.help =
"This TU56 simulator was written by Gerold H. Pauler, pxg@pdp8.de";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);

		b.x = 2*h-5*s; b.y = i;
		b.width = 2*s+s/2; b.height = s-t;
		b.label = "CREDIT";
		b.help =
"TU56 and TD8E are trademarks of Digital Equipment Corporation";
		b.next = sublist; b.sub = NOBOX;
		sublist = makebox(&b);

	}
	b.x = i-t; b.y = i-t;
	b.width = 2*h-i+2*t; b.height = 3*i;
	b.boxGC = olivGC;
	b.label = NULL;
	b.rule = linefillbox;
	b.press = logopress;
	b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
	b.next = NOBOX; b.sub = sublist;
	sublist = makebox(&b); /* the logo bar across the top */

	td8ebox = sublist; /* keep wtm switch as alternate bar here */

	{
		sublist = NOBOX;
		b.label = NULL;
		b.rule = fillbox;
		b.boxGC = blackGC;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";

		{
			int n = 0;
			int w = (h+t-i) / 12;
			int wa[] = {1,1,2,2,1,1,2,1,1};
			b.x = i; b.y = i+t;
			for ( n = 0; n < 9; n++ ) {
				b.width = wa[n] * w; b.height = 3*i-4*t;
				b.next = sublist; b.sub = NOBOX;
				switch (n) {
				case 0:
					b.boxGC = goldGC;
					b.label = "WRITE";
					b.labGC = blackGC;
					b.labinfo = tinyinfo;
					b.press = backpress;
					b.help =
"displays status of write lock switch";
					sublist = makebox(&b);
					wrtbulb[0] = sublist;
					break;
				case 1:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					b.press = lwrtlckpress;
					b.help =
"toggles between write lock and write enable";
					sublist = makeswitch( &b, 1 );
					wrtlck[0] = sublist;
					break;
				case 2:
					b.height = i/2;
					b.boxGC = blackGC;
					b.label = "WRITE";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					b.press = logopress;
					b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = b.y + b.height;
					b.label = "ENABLE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-4*t;
					b.label = "WRITE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = b.y + b.height;
					b.label = "LOCK";
					sublist = makebox(&b);
					break;
				case 3:
#ifdef TD8E0
					b.label = "0";
#endif
#ifdef TD8E1
					b.label = "2";
#endif
#ifdef TD8E2
					b.label = "4";
#endif
#ifdef TD8E3
					b.label = "6";
#endif
					b.labGC = headGC;
					b.labinfo = headinfo;
					sublist = makebox(&b);
					break;
				case 4:
					b.height = i;
					b.boxGC = blackGC;
					b.label = "-->";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-4*t;
					b.label = "<--";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					sublist = makebox(&b);
					break;
				case 5:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					sublist = makeswitch( &b, 2 );
					break;
				case 6:
					b.height = i;
					b.boxGC = blackGC;
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					b.label = "REMOTE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-4*t;
					b.label = "LOCAL";
					sublist = makebox(&b);
					b.y = i+t;
					b.height = 3*i-4*t;

					b.next = sublist;
					b.label = "OFF";
					sublist = makebox(&b);
					break;
				case 7:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					sublist = makeswitch( &b, 1 );
					break;
				case 8:
					rmtlist = sublist;
					{
						b.width = h-t - b.x;
						b.height = i+p-2*t;
						b.boxGC = goldGC;
						b.labGC = blackGC;
						b.labinfo = tinyinfo;
						b.label = "REMOTE";
						b.press = backpress;
						b.help =
"displays status of write lock switch";
						b.next = NOBOX;
						sublist = makebox(&b);

						b.y = 3*i-6*t;
						b.label = "SELECT";
						b.next = sublist;
						sublist = makebox(&b);
					}
					b.y = i+t;
					b.height = 3*i-4*t;
					b.label = NULL;
					b.sub = sublist;
					b.next = rmtlist;
					sublist = makebox(&b);
					selbulb[0] = sublist;
					break;
				default:
					break;
				}
				b.x = b.x + b.width;
				b.y = i+t;
			}
		}	

		b.x = i-t; b.y = i-t;
		b.width = h+t-i; b.height = 3*i;
		b.rule = linefillbox;
		b.boxGC = blackGC;
		b.label = NULL;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
		b.next = NOBOX; b.sub = sublist;
		sublist = makebox(&b);	/* backgrnd for TU56 controls */
		tmplist = sublist;

		sublist = NOBOX;
		b.label = NULL;
		b.rule = fillbox;
		b.boxGC = blackGC;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
		b.help = NULL;

		{
			int n = 0;
			int w = (h+t-i) / 12;
			int wa[] = {1,1,2,2,1,1,2,1,1};
			b.x = i+h+t; b.y = i+t;
			for ( n = 0; n < 9; n++ ) {
				b.width = wa[n] * w; b.height = 3*i-4*t;
				b.next = sublist; b.sub = NOBOX;
				switch (n) {
				case 0:
					b.boxGC = goldGC;
					b.label = "WRITE";
					b.labGC = blackGC;
					b.labinfo = tinyinfo;
					b.press = backpress;
					b.help =
"displays status of write lock switch";
					sublist = makebox(&b);
					wrtbulb[1] = sublist;
					break;
				case 1:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					b.press = rwrtlckpress;
					b.help =
"toggles between write lock and write enable";
					sublist = makeswitch( &b, 1 );
					wrtlck[1] = sublist;
					break;
				case 2:
					b.height = i/2;
					b.boxGC = blackGC;
					b.label = "WRITE";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					b.press = logopress;
					b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = b.y + b.height;
					b.label = "ENABLE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-3*t;
					b.label = "WRITE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = b.y + b.height;
					b.label = "LOCK";
					sublist = makebox(&b);
					break;
				case 3:
#ifdef TD8E0
					b.label = "1";
#endif
#ifdef TD8E1
					b.label = "3";
#endif
#ifdef TD8E2
					b.label = "5";
#endif
#ifdef TD8E3
					b.label = "7";
#endif
					b.labGC = headGC;
					b.labinfo = headinfo;
					sublist = makebox(&b);
					break;
				case 4:
					b.height = i;
					b.boxGC = blackGC;
					b.label = "-->";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-4*t;
					b.label = "<--";
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					sublist = makebox(&b);
					break;
				case 5:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					sublist = makeswitch( &b, 2 );
					break;
				case 6:
					b.height = i;
					b.boxGC = blackGC;
					b.labGC = whiteGC;
					b.labinfo = tinyinfo;
					b.label = "REMOTE";
					sublist = makebox(&b);

					b.next = sublist;
					b.y = 3*i-4*t;
					b.label = "LOCAL";
					sublist = makebox(&b);
					b.y = i+t;
					b.height = 3*i-4*t;

					b.next = sublist;
					b.label = "OFF";
					sublist = makebox(&b);
					break;
				case 7:
					b.boxGC = darkolivGC;
					b.labGC = olivGC;
					b.label = NULL;
					sublist = makeswitch( &b, 1 );
					break;
				case 8:
					rmtlist = sublist;
					{
						b.width = h+h - b.x;
						b.height = i+p-2*t;
						b.boxGC = goldGC;
						b.labGC = blackGC;
						b.labinfo = tinyinfo;
						b.label = "REMOTE";
						b.press = backpress;
						b.help =
"displays status of write lock switch";
						b.next = NOBOX;
						sublist = makebox(&b);

						b.y = 3*i-6*t;
						b.label = "SELECT";
						b.next = sublist;
						sublist = makebox(&b);
					}
					b.y = i+t;
					b.height = 3*i-4*t;
					b.label = NULL;
					b.sub = sublist;
					b.next = rmtlist;
					sublist = makebox(&b);
					selbulb[1] = sublist;
					break;
				default:
					break;
				}
				b.x = b.x + b.width;
				b.y = i+t;
			}
		}	

		b.x = i+h; b.y = i-t;
		b.width = h+t-i; b.height = 3*i;
		b.rule = linefillbox;
		b.boxGC = blackGC;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
		b.next = tmplist; b.sub = sublist;
		sublist = makebox(&b);	/* backgrnd for TU56 right panel */
	}
	panelbox = sublist;

#ifdef TD8E0
	boxlist->sub = td8ebox; /* patch in td8e wtm switch */
#else
	boxlist->sub = panelbox; /* patch in td8e wtm switch */
#endif
	logobox = boxlist;

	{
		b.label = NULL;
		b.labGC = subGC;
		b.labinfo = subinfo;
		b.labx = 0;
		b.laby = 0;

		{
			b.label = NULL;
			b.press = reelpress;
			b.help = "shows the name of the mounted file";

			{
			 {
			  b.x = 2*i+h/2-p-t; b.y = 7*i-t+p;
			  b.width = 3*i; b.height = 3*i;
			  b.rule = circlebox;
			  b.boxGC = darkgreyGC;
			  b.next = NOBOX; b.sub = NOBOX;
			  sublist = makebox(&b);	/* right tape hub */
			 }
			 b.boxGC = terraGC;
			 b.next = NOBOX; b.sub = sublist;
			 sublist = makebox(&b);	/* right tape */
			 rtape[0] = sublist;
			}
			b.x = i+h/2-p-t; b.y = 6*i-t+p;
			b.width = 5*i; b.height = 5*i;
			b.boxGC = whiteGC;
			b.next = NOBOX; b.sub = sublist;
			sublist = makebox(&b);	/* rigth tape reel */
			rreel[0] = sublist;

			b.press = reelpress;
			b.help = "shows the name of the mounted file";
			{
			 {
			  b.x = 2*i-2*t-p; b.y = 7*i-t+p;
			  b.width = 3*i; b.height = 3*i;
			  b.rule = circlebox;
			  b.boxGC = darkgreyGC;
			  b.next = NOBOX; b.sub = NOBOX;
			  sublist = makebox(&b);	/* left tape hub */
			 }
			 b.boxGC = terraGC;
			 b.next = NOBOX; b.sub = sublist;
			 sublist = makebox(&b);	/* left tape */
			 ltape[0] = sublist;
			}
			b.x = i-2*t-p; b.y = 6*i-t+p;
			b.width = 5*i; b.height = 5*i;
			b.boxGC = whiteGC;
			b.next = rreel[0]; b.sub = sublist;
			sublist = makebox(&b);	/* left tape reel */
			lreel[0] = sublist;

			b.x = i/4+h/2-p-t; b.y = 4*i-t+p;
			b.width = 3*p; b.height = 2*i;
			b.rule = linefillbox;
			b.boxGC = greyGC;
			b.next = sublist; b.sub = NOBOX;
			sublist = makebox(&b);	/* read/write head */

		}
		b.x = i-t; b.y = 4*i;
		b.width = h+t-i; b.height = 8*i-t;
		b.rule = fillbox;
		b.boxGC = blackGC;
		b.label = NULL;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
		b.next = NOBOX; b.sub = sublist;
		sublist = makebox(&b);	/* backgrnd for TU56 left drive */
		leftbox = sublist;

		{
			b.label = NULL;
			b.press = reelpress;
			b.help = "shows the name of the mounted file";
			{
			 {
			  b.x = h+2*i+h/2-p+t; b.y = 7*i-t+p;
			  b.width = 3*i; b.height = 3*i;
			  b.rule = circlebox;
			  b.boxGC = darkgreyGC;
			  b.next = NOBOX; b.sub = NOBOX;
			  sublist = makebox(&b);	/* right tape hub */
			 }
			 b.boxGC = terraGC;
			 b.next = NOBOX; b.sub = sublist;
			 sublist = makebox(&b);	/* right tape */
			 rtape[1] = sublist;
			}
			b.x = h+i+h/2-p+t; b.y = 6*i-t+p;
			b.width = 5*i; b.height = 5*i;
			b.boxGC = whiteGC;
			b.next = NOBOX; b.sub = sublist;
			sublist = makebox(&b);	/* rigth tape reel */
			rreel[1] = sublist;

			b.press = reelpress;
			b.help = "shows the name of the mounted file";
			{
			 {
			  b.x = h+2*i-t-p+t; b.y = 7*i-t+p;
			  b.width = 3*i; b.height = 3*i;
			  b.rule = circlebox;
			  b.boxGC = darkgreyGC;
			  b.next = NOBOX; b.sub = NOBOX;
			  sublist = makebox(&b);	/* left tape hub */
			 }
			 b.boxGC = terraGC;
			 b.next = NOBOX; b.sub = sublist;
			 sublist = makebox(&b);	/* left tape */
			 ltape[1] = sublist;
			}
			b.x = h+i-t-p+t; b.y = 6*i-t+p;
			b.width = 5*i; b.height = 5*i;
			b.boxGC = whiteGC;
			b.next = rreel[1]; b.sub = sublist;
			sublist = makebox(&b);	/* left tape reel */
			lreel[1] = sublist;

			b.x = h+i/4+h/2-p+t; b.y = 4*i-t+p;
			b.width = 3*p; b.height = 2*i;
			b.rule = linefillbox;
			b.boxGC = greyGC;
			b.next = sublist; b.sub = NOBOX;
			sublist = makebox(&b);	/* read/write head */

		}
		b.x = i+h; b.y = 4*i;
		b.width = h+t-i; b.height = 8*i-t;
		b.rule = fillbox;
		b.boxGC = blackGC;
		b.label = NULL;
		b.press = logopress;
		b.help =
"This area toggles between TD8E wtm switch and the TU56 controls";
		b.next = leftbox; b.sub = sublist;
		sublist = makebox(&b);	/* backgrnd for TU56 right drive */
		rightbox = sublist;
	}
	b.x = i-2*t; b.y = 4*i;
	b.width = 2*h-i+4*t; b.height = 8*i-t;
	b.rule = fillbox;
	b.boxGC = blackGC;
	b.label = NULL;
	b.press = backpress;
	b.help = "";
	b.next = boxlist; b.sub = sublist;
	boxlist = makebox(&b); /* reel box */
	reelbox = boxlist;

	{
		b.x = 2*h-s; b.y = H-i/2-s/2;
		b.width = s; b.height = s;
		b.boxGC = darkgreyGC;
		b.label = "OK";
		b.lablen = 2;
		b.labGC = subGC;
		b.rule = linefillbox;
		b.labinfo = subinfo;
		b.press = helpokpress;
		b.help = "click the left button here to close the help window";
		b.next = NOBOX; b.sub = NOBOX;
		helpok = makebox(&b);
	}
	b.x = i-t; b.y = H-i+t;
	b.width = 2*h-i+2*t; b.height = i-2*t;
	b.boxGC = blackGC;
	b.rule = blankbox;
	b.label = NULL;
	b.labx = i-t+c;
	b.laby = H-i/2+t;
	b.labGC = helpGC;
	b.labinfo = helpinfo;
	b.press = backpress;
	b.help = "click the left button on the OK box to close this window";
	b.next = boxlist; b.sub = NOBOX;
	boxlist = makebox(&b); /* help message box (unused initially) */
	helpbox = boxlist;

	/* main box */

	b.x = 0; b.y = 0;
	b.width = 2*h+i; b.height = H;
	b.boxGC = whiteGC;
	b.rule = linebox;
	b.press = backpress;
	b.help = NULL;
	b.next = NOBOX; b.sub = boxlist;
	boxlist = makebox(&b); /* main box */
}
#undef h
#undef t
#undef i
#undef s


/********************************************/
/* Implementation of control panel function */
/********************************************/

static struct timer tu56cons_delay;
static struct timer halt_delay;

static handle_button_press(w, d, e)
Widget w;
caddr_t d;
XButtonPressedEvent *e;
{
	boxpress( e->x, e->y, e->button, boxlist );
}

static handle_button_release(w, d, e)
Widget w;
caddr_t d;
XButtonReleasedEvent *e;
{
	/* NO ACTION */
}

static handle_exposure(w, d, e)
Widget w;
caddr_t d;
XExposeEvent *e;
{
	if (e->count == 0) { /* replot the whole thing */
		boxshow( boxlist );
	}
}

static void tu56cons_event()
/* all update of console display happens here! */
{
	changeregs(); /* always display any changes to registers ! */
	changewtm(); /* always display any changes to wtm switch ! */

 	schedule( &tu56cons_delay, tu56cons_interval, tu56cons_event, 0 );
}

/*********************************/
/* Window manager initialization */
/*********************************/

Widget kc8makepopupshell();

static startwindow()
{
	Arg arg[25];
	XGCValues gcvalues;
	unsigned int n;

	/*
	 *  Set up the top level to house it all
	 */
	kc8getinfo( &dpy, &scr );
	cmap = DefaultColormap(dpy, scr);

	/*
	 *  Get the fonts we need
	 */
	if ((headinfo = XLoadQueryFont( dpy,
				"-*-helvetica-bold-r-*-*-18-180-*-*-*-*-*-*" ))
	    == NULL) {
		if ((headinfo = XLoadQueryFont( dpy,
				"-*-*-*-r-*-*-16-*-*-*-*-*-*-*" ))
		    == NULL) {
			ttyrestore();exit(-1);
		}
	}

	if ((subinfo = XLoadQueryFont( dpy,
				"-*-helvetica-bold-r-*-*-10-100-*-*-*-*-*-*" ))
	    == NULL) {
		if ((subinfo = XLoadQueryFont( dpy,
				"-*-*-*-r-*-*-10-*-*-*-*-*-*-*" ))
		    == NULL) {
			ttyrestore();exit(-1);
		}
	}

	if ((tinyinfo = XLoadQueryFont( dpy,
				"-*-clean-medium-r-*-*-6-*-*-*-*-*-*-*" ))
	    == NULL) {
		if ((tinyinfo = XLoadQueryFont( dpy,
				"-*-*-*-r-*-*-6-*-*-*-*-*-*-*" ))
		    == NULL) {
			ttyrestore();exit(-1);
		}
	}

	if ((helpinfo = XLoadQueryFont( dpy,
				"-*-helvetica-medium-r-*-*-12-*-*-*-*-*-*-*" ))
	    == NULL) {
		if ((helpinfo = XLoadQueryFont( dpy,
				"-*-*-*-r-*-*-12-*-*-*-*-*-*-*" ))
		    == NULL) {
			ttyrestore();exit(-1);
		}
	}

	/*
	 * Create TU56 panel widget
	 */

	tu56panelshell = kc8makepopupshell( "TU56" );

	n = 0;
	XtSetArg(arg[n], XtNwidth, PDP8height * 21/10);          n++;
	XtSetArg(arg[n], XtNheight, TU56height);                 n++;
	XtSetArg(arg[n], XtNbackground, BlackPixel( dpy, scr )); n++;
	tu56panel = XtCreateWidget( "panel", widgetClass,
				     tu56panelshell, arg, n);
	XtManageChild(tu56panel);
	XtPopup(tu56panelshell, XtGrabNonexclusive);

	XSetWindowColormap( dpy, XtWindow(tu56panel), cmap );

	/*
	 * Create black and white Graphics Contexts
	 */

	gcvalues.foreground = BlackPixel( dpy, scr );
	gcvalues.background = BlackPixel( dpy, scr );
	gcvalues.fill_style = FillOpaqueStippled;
	gcvalues.font = tinyinfo->fid;
	blackGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFont,
			&gcvalues);

	gcvalues.foreground = WhitePixel( dpy, scr );
	gcvalues.font = tinyinfo->fid;
	whiteGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFont,
			&gcvalues);

	gcvalues.font = helpinfo->fid;
	helpGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFont,
			&gcvalues);
	
	gcvalues.font = headinfo->fid;
	headGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFont,
			&gcvalues);

	gcvalues.font = subinfo->fid;
	subGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFont,
			&gcvalues);

	/*
	 * Create monochrome Graphics Contexts
	 */

	grey.red = 128*256;
	grey.green = 128*256;
	grey.blue = 128*256;
	if (  XAllocColor( dpy, cmap, &grey )
	   && (grey.pixel != WhitePixel( dpy, scr ))
	   ) { /* we got the color we want! */
		gcvalues.foreground = grey.pixel;
		greyGC = XCreateGC(dpy, XtWindow(tu56panel),
				GCForeground | GCBackground,
				&gcvalues);
	} else { /* fake it as black */
		grey.pixel = BlackPixel( dpy, scr );
		greyGC = blackGC;
	}

	darkgrey.red = 80*256;
	darkgrey.green = 80*256;
	darkgrey.blue = 80*256;
	dark_bitmap = XCreateBitmapFromData( dpy, XtWindow(tu56panel),
					     dark_bits, 16, 16);
	if (   XAllocColor( dpy, cmap, &darkgrey )
	   && (darkgrey.pixel != grey.pixel)
	   ) { /* we got the color we want */
		gcvalues.foreground = darkgrey.pixel;
		darkgreyGC = XCreateGC(dpy, XtWindow(tu56panel),
				GCForeground | GCBackground,
				&gcvalues);
	} else if (greyGC != blackGC) { /* fake it as stippled grey */
		darkgrey.pixel = grey.pixel;
		gcvalues.foreground = darkgrey.pixel;
		gcvalues.stipple = dark_bitmap;
		darkgreyGC = XCreateGC(dpy, XtWindow(tu56panel),
				GCForeground | GCBackground |
				GCFillStyle | GCStipple,
				&gcvalues);
	} else { /* give up and use black */
		darkgrey.pixel = BlackPixel( dpy, scr );
		darkgreyGC = blackGC;
	}

	/*
	 * Create color Graphics Contexts
	 */

	goldenrod.red = 224*256;
	goldenrod.green = 160*256;
	goldenrod.blue = 32*256;
	gcvalues.stipple = dark_bitmap;
	if (XAllocColor( dpy, cmap, &goldenrod )) { /* we got what we want */
		gcvalues.foreground = goldenrod.pixel;
		goldGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground,
			&gcvalues);
	} else if (darkgrey.pixel != grey.pixel) { /* fake it with grey */
		goldenrod.pixel = grey.pixel;
		goldGC = greyGC;
		gcvalues.foreground = grey.pixel;
	} else { /* fake it with grey, but give up on gold/oliv difference */
		goldenrod.pixel = grey.pixel;
		goldGC = greyGC;
	}

	terracotta.red = 208*256;
	terracotta.green = 112*256;
	terracotta.blue = 64*256;
	gcvalues.stipple = dark_bitmap;
	if (XAllocColor( dpy, cmap, &terracotta )) { /* we got what we want */
		gcvalues.foreground = terracotta.pixel;
		terraGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground,
			&gcvalues);
		darkterraGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFillStyle | GCStipple,
			&gcvalues);
	} else if (darkgrey.pixel != grey.pixel) { /* fake it with darkgrey */
		terracotta.pixel = darkgrey.pixel;
		terraGC = darkgreyGC;
		gcvalues.foreground = darkgrey.pixel;
		darkterraGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFillStyle | GCStipple,
			&gcvalues);
	} else { /* fake it with grey; give up on gold/terra difference */
		terracotta.pixel = grey.pixel;
		terraGC = greyGC;
		darkterraGC = darkgreyGC;
	}

	olivgreen.red = 85*256;
	olivgreen.green = 107*256;
	olivgreen.blue = 47*256;
	gcvalues.stipple = dark_bitmap;
	if (XAllocColor( dpy, cmap, &olivgreen )) { /* we got what we want */
		gcvalues.foreground = olivgreen.pixel;
		olivGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground,
			&gcvalues);
		darkolivGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFillStyle | GCStipple,
			&gcvalues);
	} else if (darkgrey.pixel != grey.pixel) { /* fake it with darkgrey */
		olivgreen.pixel = darkgrey.pixel;
		olivGC = darkgreyGC;
		gcvalues.foreground = darkgrey.pixel;
		darkolivGC = XCreateGC(dpy, XtWindow(tu56panel),
			GCForeground | GCBackground | GCFillStyle | GCStipple,
			&gcvalues);
	} else { /* fake it with grey; give up on gold/oliv difference */
		olivgreen.pixel = grey.pixel;
		olivGC = greyGC;
		darkolivGC = darkgreyGC;
	}

	/*
	 * Setup to handle events
	 */

	XtAddEventHandler(tu56panel, ButtonPressMask, FALSE,
			  (void *)handle_button_press, NULL);
	XtAddEventHandler(tu56panel, ButtonReleaseMask, FALSE,
			  (void *)handle_button_release, NULL);
	XtAddEventHandler(tu56panel, LeaveWindowMask, FALSE,
			  (void *)handle_button_release, NULL);
	XtAddEventHandler(tu56panel, ExposureMask, FALSE,
			  (void *)handle_exposure, NULL);

} 

/**********************************************************/
/* Interface between cpu implementation and control panel */
/**********************************************************/

TU56_power() /* power-on initialize */
{
	init_timer( tu56cons_delay );
	schedule( &tu56cons_delay, tu56cons_interval, tu56cons_event, 0 );
	startwindow();
	makeboxes();
	/* ensure tu56panel is always visible after start */
	boxshow(boxlist);
}

TU56_init() /* console reset */
{
	changeregs();
}

