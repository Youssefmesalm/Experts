//+------------------------------------------------------------------+
//|                                                     GraphINI.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://mql5.com/en/users/artmedia70"
//+------------------------------------------------------------------+
//| Macro substitutions                                              |
//+------------------------------------------------------------------+
#define TOTAL_COLOR_THEMES             (2)      // Number of color schemes
//+------------------------------------------------------------------+
//| Enumerations                                                     |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| List of color scheme indices                                     |
//+------------------------------------------------------------------+
enum ENUM_COLOR_THEMES
  {
   COLOR_THEME_BLUE_STEEL,                      // Blue steel
   COLOR_THEME_LIGHT_CYAN_GRAY,                 // Light cyan gray
  };
//+------------------------------------------------------------------+
//| List of indices of color scheme parameters                       |
//+------------------------------------------------------------------+
enum ENUM_COLOR_THEME_COLORS
  {
   COLOR_THEME_COLOR_FORM_BG,                   // Form background color
   COLOR_THEME_COLOR_FORM_FRAME,                // Form frame color
   COLOR_THEME_COLOR_FORM_RECT_OUTER,           // Form outline rectangle color
   COLOR_THEME_COLOR_FORM_SHADOW,               // Form shadow color
  };
#define TOTAL_COLOR_THEME_COLORS       (4)      // Number of parameters in the color theme
//+------------------------------------------------------------------+
//| The array containing color schemes                               |
//+------------------------------------------------------------------+
color array_color_themes[TOTAL_COLOR_THEMES][TOTAL_COLOR_THEME_COLORS]=
  {
//--- Parameters of the "Blue steel" color scheme
   {
      C'134,160,181',                           // Form background color
      C'134,160,181',                           // Form frame color
      clrDimGray,                               // Form outline rectangle color
      clrGray,                                  // Form shadow color
   },
//--- Parameters of the "Light cyan gray" color scheme
   {
      C'181,196,196',                           // Form background color
      C'181,196,196',                           // Form frame color
      clrGray,                                  // Form outline rectangle color
      clrGray,                                  // Form shadow color
   },
  };
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Smoothing types                                                  |
//+------------------------------------------------------------------+
enum ENUM_SMOOTHING_TYPE
  {
   SMOOTHING_TYPE_NONE,                         // No smoothing
   SMOOTHING_TYPE_AA,                           // Anti-aliasing
   SMOOTHING_TYPE_WU,                           // Wu
   SMOOTHING_TYPE_THICK,                        // Thick
   SMOOTHING_TYPE_DUAL,                         // Dual
  };
//+------------------------------------------------------------------+
//| Frame styles                                                     |
//+------------------------------------------------------------------+
enum ENUM_FRAME_STYLE
  {
   FRAME_STYLE_SIMPLE,                          // Simple frame
   FRAME_STYLE_FLAT,                            // Flat frame
   FRAME_STYLE_BEVEL,                           // Embossed (convex)
   FRAME_STYLE_STAMP,                           // Embossed (concave)
  };
//+------------------------------------------------------------------+
//| Form types                                                       |
//+------------------------------------------------------------------+
enum ENUM_FORM_TYPE
  {
   FORM_TYPE_SQUARE,                            // Rectangular
  };
//+------------------------------------------------------------------+
//| Form styles                                                      |
//+------------------------------------------------------------------+
enum ENUM_FORM_STYLE
  {
   FORM_STYLE_FLAT,                             // Flat form
   FORM_STYLE_BEVEL,                            // Embossed form
  };
#define TOTAL_FORM_STYLES
//+------------------------------------------------------------------+
//| List of form style parameter indices                             |
//+------------------------------------------------------------------+
enum ENUM_FORM_STYLE_PARAMS
  {
   FORM_STYLE_FRAME_WIDTH_LEFT,                 // Form frame width to the left
   FORM_STYLE_FRAME_WIDTH_RIGHT,                // Form frame width to the right
   FORM_STYLE_FRAME_WIDTH_TOP,                  // Form frame width on top
   FORM_STYLE_FRAME_WIDTH_BOTTOM,               // Form frame width below
   FORM_STYLE_FRAME_SHADOW_OPACITY,             // Shadow opacity
   FORM_STYLE_FRAME_SHADOW_BLUR,                // Shadow blur
   FORM_STYLE_DARKENING_COLOR_FOR_SHADOW,       // Form shadow color darkening
   FORM_STYLE_FRAME_SHADOW_X_SHIFT,             // Shadow X axis shift
   FORM_STYLE_FRAME_SHADOW_Y_SHIFT,             // Shadow Y axis shift
  };
#define TOTAL_FORM_STYLE_PARAMS        (9)      // Number of form style parameters
//+------------------------------------------------------------------+
//| Array containing form style parameters                           |
//+------------------------------------------------------------------+
int array_form_style[TOTAL_FORM_STYLES][TOTAL_FORM_STYLE_PARAMS]=
  {
//--- "Flat form" style parameters
   {
      3,                                        // Form frame width to the left
      3,                                        // Form frame width to the right
      3,                                        // Form frame width on top
      3,                                        // Form frame width below
      80,                                       // Shadow opacity
      4,                                        // Shadow blur
      80,                                       // Form shadow color darkening
      2,                                        // Shadow X axis shift
      2,                                        // Shadow Y axis shift
   },
//--- "Embossed form" style parameters
   {
      4,                                        // Form frame width to the left
      4,                                        // Form frame width to the right
      4,                                        // Form frame width on top
      4,                                        // Form frame width below
      80,                                       // Shadow opacity
      4,                                        // Shadow blur
      80,                                       // Form shadow color darkening
      2,                                        // Shadow X axis shift
      2,                                        // Shadow Y axis shift
   },
  };
//+------------------------------------------------------------------+
