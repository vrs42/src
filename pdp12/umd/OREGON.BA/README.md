# OREGON.BA
A port of the original Oregon Trail to OS/8 BASIC. 

# Introduction

The basis of this port is the [May 1978 Creative Computing version of Oregon Trail](https://github.com/clintmoyer/oregon-trail/) as transcribed by [@clintmoyer](https://github.com/clintmoyer).

The PDP-8 and PDP-12 use the OS/8 version of BASIC, which is missing some of the features necessary to run the 1978 code.

# Errors

Running the original code produces a number of compile-time errors:

```
XC 1180
LS 1290
LS 1300
XC 1980
LS 2270
XC 2870
LS 3640
LS 3650
LS 5560
XC 6200
XC 6210
XC 6230
TS 
```

The meanings of these errors can be found in [the OS/8 Handbook](https://bitsavers.org/pdf/dec/pdp8/os8/OS8_Handbook_Apr1974.pdf) on page 6-115 (624 in the PDF). This project has [an issue created for each error](https://github.com/UMDLARS/OREGON.BA/issues); we will push commits to fix each error and document the fix in the issue and commits. Hopefully we'll end up with a version of Oregon Trail that can be played on OS/8.

# Fun Fact

The name OREGON.BA is due to OS/8's 6.2 naming limitation.
