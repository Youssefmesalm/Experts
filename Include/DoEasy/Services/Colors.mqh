//+------------------------------------------------------------------+
//|                                                       Colors.mqh |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                             https://mql5.com/en/users/artmedia70 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com/en/users/integer"
#property version   "1.00"
#property strict    // Necessary for mql4
//+------------------------------------------------------------------+
//| Class for working with color                                     |
//+------------------------------------------------------------------+
class CColors
  {
private:
   static double     Arctan2(const double x,const double y);
   static double     Hue_To_RGB(double v1,double v2,double vH);
public:
//+--------------------------------------------------------------------+
//| The list of functions from http://www.easyrgb.com/index.php?X=MATH |
//+--------------------------------------------------------------------+
   static void       RGBtoXYZ(const double aR,const double aG,const double aB,double &oX,double &oY,double &oZ);
   static void       XYZtoRGB(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB);
   static void       XYZtoYxy(const double aX,const double aY,const double aZ,double &oY,double &ox,double &oy);
   static void       YxyToXYZ(const double aY,const double ax,const double ay,double &oX,double &oY,double &oZ);
   static void       XYZtoHunterLab(const double aX,const double aY,const double aZ,double &oL,double &oa,double &ob);
   static void       HunterLabToXYZ(const double aL,const double aa,const double ab,double &oX,double &oY,double &oZ);
   static void       XYZtoCIELab(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEa,double &oCIEb);
   static void       CIELabToXYZ(const double aCIEL,const double aCIEa,const double aCIEb,double &oX,double &oY,double &oZ);
   static void       CIELabToCIELCH(const double aCIEL,const double aCIEa,const double aCIEb,double &oCIEL,double &oCIEC,double &oCIEH);
   static void       CIELCHtoCIELab(const double aCIEL,const double aCIEC,const double aCIEH,double &oCIEL,double &oCIEa,double &oCIEb);
   static void       XYZtoCIELuv(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEu,double &oCIEv);
   static void       CIELuvToXYZ(const double aCIEL,const double aCIEu,const double aCIEv,double &oX,double &oY,double &oZ);
   static void       RGBtoHSL(const double aR,const double aG,const double aB,double &oH,double &oS,double &oL);
   static void       HSLtoRGB(const double aH,const double aS,const double aL,double &oR,double &oG,double &oB);
   static void       RGBtoHSV(const double aR,const double aG,const double aB,double &oH,double &oS,double &oV);
   static void       HSVtoRGB(const double aH,const double aS,const double aV,double &oR,double &oG,double &oB);
   static void       RGBtoCMY(const double aR,const double aG,const double aB,double &oC,double &oM,double &oY);
   static void       CMYtoRGB(const double aC,const double aM,const double aY,double &oR,double &oG,double &oB);
   static void       CMYtoCMYK(const double aC,const double aM,const double aY,double &oC,double &oM,double &oY,double &oK);
   static void       CMYKtoCMY(const double aC,const double aM,const double aY,const double aK,double &oC,double &oM,double &oY);
//+------------------------------------------------------------------+
//| Other functions for working with color                           |
//+------------------------------------------------------------------+
   static void       RGBtoLab(const double aR,const double aG,const double aB,double &oL,double &oa,double &ob);
   static void       ColorToRGB(const color aColor,double &aR,double &aG,double &aB);
   static double     GetR(const color aColor);
   static double     GetG(const color aColor);
   static double     GetB(const color aColor);
   static double     GetA(const color aColor);
   static color      RGBToColor(const double aR,const double aG,const double aB);
   static color      MixColors(const color aCol1,const color aCol2,const double aK);
   static color      BlendColors(const uint lower_color,const uint upper_color);
   static void       Gradient(color &aColors[],color &aOut[],int aOutCount,bool aCycle=false);
   static void       RGBtoXYZsimple(double aR,double aG,double aB,double &oX,double &oY,double &oZ);
   static void       XYZtoRGBsimple(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB);
   static color      Negative(const color aColor);
   static color      StandardColor(const color aColor,int &aIndex);
   static double     RGBtoGray(double aR,double aG,double aB);
   static double     RGBtoGraySimple(double aR,double aG,double aB);
  };
//+------------------------------------------------------------------+
//| Class methods                                                    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Arctan2                                                          |
//+------------------------------------------------------------------+
double CColors::Arctan2(const double x,const double y)
  {
   if(y==0)
      return(x<0 ? M_PI : 0);
   else
     {
      if(x>0)
         return(::atan(y/x));
      if(x<0)
         return(y>0 ? atan(y/x)+M_PI : atan(y/x)-M_PI);
      else
         return(y<0 ? -M_PI_2 : M_PI_2);
     }
  }
//+------------------------------------------------------------------+
//| Hue_To_RGB                                                       |
//+------------------------------------------------------------------+
double CColors::Hue_To_RGB(double v1,double v2,double vH)
  {
   if(vH<0)
      vH+=1.0;
   if(vH>1.0)
      vH-=1;
   if((6.0*vH)<1.0)
      return(v1+(v2-v1)*6.0*vH);
   if((2.0*vH)<1.0)
      return(v2);
   if((3.0*vH)<2.0)
      return(v1+(v2-v1)*((2.0/3.0)-vH)*6.0);
//---
   return(v1);
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into XYZ                                       |
//+------------------------------------------------------------------+
void CColors::RGBtoXYZ(const double aR,const double aG,const double aB,double &oX,double &oY,double &oZ)
  {
   double var_R=aR/255;
   double var_G=aG/255;
   double var_B=aB/255;
//---
   if(var_R>0.04045)
      var_R=::pow((var_R+0.055)/1.055,2.4);
   else
      var_R=var_R/12.92;
//---
   if(var_G>0.04045)
      var_G=::pow((var_G+0.055)/1.055,2.4);
   else
      var_G=var_G/12.92;
//---
   if(var_B>0.04045)
      var_B=::pow((var_B+0.055)/1.055,2.4);
   else
      var_B=var_B/12.92;
//---
   var_R =var_R*100.0;
   var_G =var_G*100.0;
   var_B =var_B*100.0;
   oX    =var_R*0.4124+var_G*0.3576+var_B*0.1805;
   oY    =var_R*0.2126+var_G*0.7152+var_B*0.0722;
   oZ    =var_R*0.0193+var_G*0.1192+var_B*0.9505;
  }
//+------------------------------------------------------------------+
//| Conversion of XYZ into RGB                                       |
//+------------------------------------------------------------------+
void CColors::XYZtoRGB(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB)
  {
   double var_X =aX/100;
   double var_Y =aY/100;
   double var_Z =aZ/100;
   double var_R =var_X*3.2406+var_Y*-1.5372+var_Z*-0.4986;
   double var_G =var_X*(-0.9689)+var_Y*1.8758+var_Z*0.0415;
   double var_B =var_X*0.0557+var_Y*(-0.2040)+var_Z*1.0570;
//---
   if(var_R>0.0031308)
      var_R=1.055*(::pow(var_R,1.0/2.4))-0.055;
   else
      var_R=12.92*var_R;
//---
   if(var_G>0.0031308)
      var_G=1.055*(::pow(var_G,1.0/2.4))-0.055;
   else
      var_G=12.92*var_G;
//---
   if(var_B>0.0031308)
      var_B=1.055*(::pow(var_B,1.0/2.4))-0.055;
   else
      var_B=12.92*var_B;
//---
   oR =var_R*255.0;
   oG =var_G*255.0;
   oB =var_B*255.0;
  }
//+------------------------------------------------------------------+
//| Conversion of XYZ into Yxy                                       |
//+------------------------------------------------------------------+
void CColors::XYZtoYxy(const double aX,const double aY,const double aZ,double &oY,double &ox,double &oy)
  {
   oY =aY;
   ox =aX/(aX+aY+aZ);
   oy =aY/(aX+aY+aZ);
  }
//+------------------------------------------------------------------+
//| Conversion of Yxy into XYZ                                       |
//+------------------------------------------------------------------+
void CColors::YxyToXYZ(const double aY,const double ax,const double ay,double &oX,double &oY,double &oZ)
  {
   oX =ax*(aY/ay);
   oY =aY;
   oZ =(1.0-ax-ay)*(aY/ay);
  }
//+------------------------------------------------------------------+
//| Conversion of XYZ into HunterLab                                 |
//+------------------------------------------------------------------+
void CColors::XYZtoHunterLab(const double aX,const double aY,const double aZ,double &oL,double &oa,double &ob)
  {
   oL =10.0*::sqrt(aY);
   oa =17.5*(((1.02*aX)-aY)/::sqrt(aY));
   ob =7.0*((aY-(0.847*aZ))/::sqrt(aY));
  }
//+------------------------------------------------------------------+
//| Conversion of HunterLab into XYZ                                 |
//+------------------------------------------------------------------+
void CColors::HunterLabToXYZ(const double aL,const double aa,const double ab,double &oX,double &oY,double  &oZ)
  {
   double var_Y =aL/10.0;
   double var_X =aa/17.5*aL/10.0;
   double var_Z =ab/7.0*aL/10.0;
//---
   oY =::pow(var_Y,2);
   oX =(var_X+oY)/1.02;
   oZ =-(var_Z-oY)/0.847;
  }
//+------------------------------------------------------------------+
//| Conversion of XYZ into CIELab                                    |
//+------------------------------------------------------------------+
void CColors::XYZtoCIELab(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEa,double &oCIEb)
  {
   double ref_X =95.047;
   double ref_Y =100.0;
   double ref_Z =108.883;
   double var_X =aX/ref_X;
   double var_Y =aY/ref_Y;
   double var_Z =aZ/ref_Z;
//---
   if(var_X>0.008856)
      var_X=::pow(var_X,1.0/3.0);
   else
      var_X=(7.787*var_X)+(16.0/116.0);
//---
   if(var_Y>0.008856)
      var_Y=::pow(var_Y,1.0/3.0);
   else
      var_Y=(7.787*var_Y)+(16.0/116.0);
//---
   if(var_Z>0.008856)
      var_Z=::pow(var_Z,1.0/3.0);
   else
      var_Z=(7.787*var_Z)+(16.0/116.0);
//---
   oCIEL =(116.0*var_Y)-16.0;
   oCIEa =500.0*(var_X-var_Y);
   oCIEb =200*(var_Y-var_Z);
  }
//+------------------------------------------------------------------+
//| Conversion of CIELab into ToXYZ                                  |
//+------------------------------------------------------------------+
void CColors::CIELabToXYZ(const double aCIEL,const double aCIEa,const double aCIEb,double &oX,double &oY,double &oZ)
  {
   double var_Y =(aCIEL+16.0)/116.0;
   double var_X =aCIEa/500.0+var_Y;
   double var_Z =var_Y-aCIEb/200.0;
//---
   if(::pow(var_Y,3)>0.008856)
      var_Y=::pow(var_Y,3);
   else
      var_Y=(var_Y-16.0/116.0)/7.787;
//---
   if(::pow(var_X,3)>0.008856)
      var_X=::pow(var_X,3);
   else
      var_X=(var_X-16.0/116.0)/7.787;
//---
   if(::pow(var_Z,3)>0.008856)
      var_Z=::pow(var_Z,3);
   else
      var_Z=(var_Z-16.0/116.0)/7.787;
//---
   double ref_X =95.047;
   double ref_Y =100.0;
   double ref_Z =108.883;
//---
   oX =ref_X*var_X;
   oY =ref_Y*var_Y;
   oZ =ref_Z*var_Z;
  }
//+------------------------------------------------------------------+
//| Conversion of CIELab into CIELCH                                 |
//+------------------------------------------------------------------+
void CColors::CIELabToCIELCH(const double aCIEL,const double aCIEa,const double aCIEb,double &oCIEL,double &oCIEC,double &oCIEH)
  {
   double var_H=Arctan2(aCIEb,aCIEa);
//---
   if(var_H>0)
      var_H=(var_H/M_PI)*180.0;
   else
      var_H=360.0-(::fabs(var_H)/M_PI)*180.0;
//---
   oCIEL =aCIEL;
   oCIEC =::sqrt(::pow(aCIEa,2)+::pow(aCIEb,2));
   oCIEH =var_H;
  }
//+------------------------------------------------------------------+
//| Conversion of CIELCH into CIELab                                 |
//+------------------------------------------------------------------+
void CColors::CIELCHtoCIELab(const double aCIEL,const double aCIEC,const double aCIEH,double &oCIEL,double &oCIEa,double &oCIEb)
  {
//--- Arguments from 0 to 360°
   oCIEL =aCIEL;
   oCIEa =::cos(M_PI*aCIEH/180.0)*aCIEC;
   oCIEb =::sin(M_PI*aCIEH/180)*aCIEC;
  }
//+------------------------------------------------------------------+
//| Conversion of XYZ into CIELuv                                    |
//+------------------------------------------------------------------+
void CColors::XYZtoCIELuv(const double aX,const double aY,const double aZ,double &oCIEL,double &oCIEu,double &oCIEv)
  {
   double var_U =(4.0*aX)/(aX+(15.0*aY)+(3.0*aZ));
   double var_V =(9.0*aY)/(aX+(15.0*aY)+(3.0*aZ));
   double var_Y =aY/100.0;
//---
   if(var_Y>0.008856)
      var_Y=::pow(var_Y,1.0/3.0);
   else
      var_Y=(7.787*var_Y)+(16.0/116.0);
//---
   double ref_X =95.047;
   double ref_Y =100.000;
   double ref_Z =108.883;
   double ref_U =(4.0*ref_X)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double ref_V =(9.0*ref_Y)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
//---
   oCIEL =(116.0*var_Y)-16.0;
   oCIEu =13.0*oCIEL*(var_U-ref_U);
   oCIEv =13.0*oCIEL*(var_V-ref_V);
  }
//+------------------------------------------------------------------+
//| Conversion of CIELuv into XYZ                                    |
//+------------------------------------------------------------------+
void CColors::CIELuvToXYZ(const double aCIEL,const double aCIEu,const double aCIEv,double &oX,double &oY,double &oZ)
  {
   double var_Y=(aCIEL+16.0)/116.0;
//---
   if(::pow(var_Y,3)>0.008856)
      var_Y=::pow(var_Y,3);
   else
      var_Y=(var_Y-16.0/116.0)/7.787;
//---
   double ref_X =95.047;
   double ref_Y =100.000;
   double ref_Z =108.883;
   double ref_U =(4.0*ref_X)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double ref_V =(9.0*ref_Y)/(ref_X+(15.0*ref_Y)+(3.0*ref_Z));
   double var_U =aCIEu/(13.0*aCIEL)+ref_U;
   double var_V =aCIEv/(13.0*aCIEL)+ref_V;
//---
   oY=var_Y*100.0;
   oX=-(9.0*oY*var_U)/((var_U-4.0)*var_V-var_U*var_V);
   oZ=(9.0*oY-(15.0*var_V*oY)-(var_V*oX))/(3.0*var_V);
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into HSL                                       |
//+------------------------------------------------------------------+
void CColors::RGBtoHSL(const double aR,const double aG,const double aB,double &oH,double &oS,double &oL)
  {
   double var_R   =(aR/255);
   double var_G   =(aG/255);
   double var_B   =(aB/255);
   double var_Min =::fmin(var_R,::fmin(var_G,var_B));
   double var_Max =::fmax(var_R,::fmax(var_G,var_B));
   double del_Max =var_Max-var_Min;
//---
   oL=(var_Max+var_Min)/2;
//---
   if(del_Max==0)
     {
      oH=0;
      oS=0;
     }
   else
     {
      if(oL<0.5)
         oS=del_Max/(var_Max+var_Min);
      else
         oS=del_Max/(2.0-var_Max-var_Min);
      //---
      double del_R =(((var_Max-var_R)/6.0)+(del_Max/2.0))/del_Max;
      double del_G =(((var_Max-var_G)/6.0)+(del_Max/2.0))/del_Max;
      double del_B =(((var_Max-var_B)/6.0)+(del_Max/2.0))/del_Max;
      //---
      if(var_R==var_Max)
         oH=del_B-del_G;
      else if(var_G==var_Max)
         oH=(1.0/3.0)+del_R-del_B;
      else if(var_B==var_Max)
         oH=(2.0/3.0)+del_G-del_R;
      //---
      if(oH<0)
         oH+=1.0;
      //---
      if(oH>1)
         oH-=1.0;
     }
  }
//+------------------------------------------------------------------+
//| Conversion of HSL into RGB                                       |
//+------------------------------------------------------------------+
void CColors::HSLtoRGB(const double aH,const double aS,const double aL,double &oR,double &oG,double &oB)
  {
   if(aS==0)
     {
      oR=aL*255;
      oG=aL*255;
      oB=aL*255;
     }
   else
     {
      double var_2=0.0;
      //---
      if(aL<0.5)
         var_2=aL*(1.0+aS);
      else
         var_2=(aL+aS)-(aS*aL);
      //---
      double var_1=2.0*aL-var_2;
      oR =255.0*Hue_To_RGB(var_1,var_2,aH+(1.0/3.0));
      oG =255.0*Hue_To_RGB(var_1,var_2,aH);
      oB =255.0*Hue_To_RGB(var_1,var_2,aH-(1.0/3.0));
     }
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into HSV                                       |
//+------------------------------------------------------------------+
void CColors::RGBtoHSV(const double aR,const double aG,const double aB,double &oH,double &oS,double &oV)
  {
   const double var_R   =(aR/255.0);
   const double var_G   =(aG/255.0);
   const double var_B   =(aB/255.0);
   const double var_Min =::fmin(var_R,::fmin(var_G, var_B));
   const double var_Max =::fmax(var_R,::fmax(var_G,var_B));
   const double del_Max =var_Max-var_Min;
//---
   oV=var_Max;
//---
   if(del_Max==0)
     {
      oH=0;
      oS=0;
     }
   else
     {
      oS=del_Max/var_Max;
      const double del_R =(((var_Max-var_R)/6.0)+(del_Max/2))/del_Max;
      const double del_G =(((var_Max-var_G)/6.0)+(del_Max/2))/del_Max;
      const double del_B =(((var_Max-var_B)/6.0)+(del_Max/2))/del_Max;
      //---
      if(var_R==var_Max)
         oH=del_B-del_G;
      else if(var_G==var_Max)
         oH=(1.0/3.0)+del_R-del_B;
      else if(var_B==var_Max)
         oH=(2.0/3.0)+del_G-del_R;
      //---
      if(oH<0)
         oH+=1.0;
      //---
      if(oH>1.0)
         oH-=1.0;
     }
  }
//+------------------------------------------------------------------+
//| Conversion of HSV into RGB                                       |
//+------------------------------------------------------------------+
void CColors::HSVtoRGB(const double aH,const double aS,const double aV,double &oR,double &oG,double &oB)
  {
   if(aS==0)
     {
      oR =aV*255.0;
      oG =aV*255.0;
      oB =aV*255.0;
     }
   else
     {
      double var_h=aH*6.0;
      //---
      if(var_h==6)
         var_h=0;
      //---
      int    var_i =int(var_h);
      double var_1 =aV*(1.0-aS);
      double var_2 =aV*(1.0-aS*(var_h-var_i));
      double var_3 =aV*(1.0-aS*(1.0-(var_h-var_i)));
      double var_r =0.0;
      double var_g =0.0;
      double var_b =0.0;
      //---
      if(var_i==0)
        {
         var_r =aV;
         var_g =var_3;
         var_b =var_1;
        }
      else if(var_i==1.0)
        {
         var_r=var_2;
         var_g=aV;
         var_b=var_1;
        }
      else if(var_i==2.0)
        {
         var_r=var_1;
         var_g=aV;
         var_b=var_3;
        }
      else if(var_i==3)
        {
         var_r=var_1;
         var_g=var_2;
         var_b=aV;
        }
      else if(var_i==4)
        {
         var_r=var_3;
         var_g=var_1;
         var_b=aV;
        }
      else
        {
         var_r=aV;
         var_g=var_1;
         var_b=var_2;
        }
      //---
      oR =var_r*255.0;
      oG =var_g*255.0;
      oB =var_b*255.0;
     }
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into CMY                                       |
//+------------------------------------------------------------------+
void CColors::RGBtoCMY(const double aR,const double aG,const double aB,double &oC,double &oM,double &oY)
  {
   oC =1.0-(aR/255.0);
   oM =1.0-(aG/255.0);
   oY =1.0-(aB/255.0);
  }
//+------------------------------------------------------------------+
//| Conversion of CMY into RGB                                       |
//+------------------------------------------------------------------+
void CColors::CMYtoRGB(const double aC,const double aM,const double aY,double &oR,double &oG,double &oB)
  {
   oR =(1.0-aC)*255.0;
   oG =(1.0-aM)*255.0;
   oB =(1.0-aY)*255.0;
  }
//+------------------------------------------------------------------+
//| Conversion of CMY into CMYK                                      |
//+------------------------------------------------------------------+
void CColors::CMYtoCMYK(const double aC,const double aM,const double aY,double &oC,double &oM,double &oY,double &oK)
  {
   double var_K=1;
//---
   if(aC<var_K)
      var_K=aC;
   if(aM<var_K)
      var_K=aM;
   if(aY<var_K)
      var_K=aY;
//---
   if(var_K==1.0)
     {
      oC =0;
      oM =0;
      oY =0;
     }
   else
     {
      oC =(aC-var_K)/(1.0-var_K);
      oM =(aM-var_K)/(1.0-var_K);
      oY =(aY-var_K)/(1.0-var_K);
     }
//---
   oK=var_K;
  }
//+------------------------------------------------------------------+
//| Conversion of CMYK into CMY                                      |
//+------------------------------------------------------------------+
void CColors::CMYKtoCMY(const double aC,const double aM,const double aY,const double aK,double &oC,double &oM,double &oY)
  {
   oC =(aC*(1.0-aK)+aK);
   oM =(aM*(1.0-aK)+aK);
   oY =(aY*(1.0-aK)+aK);
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into Lab                                       |
//+------------------------------------------------------------------+
void CColors::RGBtoLab(const double aR,const double aG,const double aB,double &oL,double &oa,double &ob)
  {
   double X=0,Y=0,Z=0;
   RGBtoXYZ(aR,aG,aB,X,Y,Z);
   XYZtoHunterLab(X,Y,Z,oL,oa,ob);
  }
//+------------------------------------------------------------------+
//| Getting values of the RGB components                             |
//+------------------------------------------------------------------+
void CColors::ColorToRGB(const color aColor,double &aR,double &aG,double &aB)
  {
   aR =GetR(aColor);
   aG =GetG(aColor);
   aB =GetB(aColor);
  }
//+------------------------------------------------------------------+
//| Getting the R component value                                    |
//+------------------------------------------------------------------+
double CColors::GetR(const color aColor)
  {
   return(aColor&0xff);
  }
//+------------------------------------------------------------------+
//| Getting the G component value                                    |
//+------------------------------------------------------------------+
double CColors::GetG(const color aColor)
  {
   return((aColor>>8)&0xff);
  }
//+------------------------------------------------------------------+
//| Getting the B component value                                    |
//+------------------------------------------------------------------+
double CColors::GetB(const color aColor)
  {
   return((aColor>>16)&0xff);
  }
//+------------------------------------------------------------------+
//| Getting the A component value                                    |
//+------------------------------------------------------------------+
double CColors::GetA(const color aColor)
  {
   return(double(uchar((aColor)>>24)));
  }
//+------------------------------------------------------------------+
//| Conversion of RGB into const color                               |
//+------------------------------------------------------------------+
color CColors::RGBToColor(const double aR,const double aG,const double aB)
  {
   int int_r =(int)::round(aR);
   int int_g =(int)::round(aG);
   int int_b =(int)::round(aB);
   int Color =0;
//---
   Color=int_b;
   Color<<=8;
   Color|=int_g;
   Color<<=8;
   Color|=int_r;
//---
   return((color)Color);
  }
//+------------------------------------------------------------------+
//| Getting the value of the intermediary color between two colors   |
//+------------------------------------------------------------------+
color CColors::MixColors(const color aCol1,const color aCol2,const double aK)
  {
//--- aK - from 0 to 1
   double R1=0.0,G1=0.0,B1=0.0,R2=0.0,G2=0.0,B2=0.0;
//---
   ColorToRGB(aCol1,R1,G1,B1);
   ColorToRGB(aCol2,R2,G2,B2);
//---
   R1+=(int)::round(aK*(R2-R1));
   G1+=(int)::round(aK*(G2-G1));
   B1+=(int)::round(aK*(B2-B1));
//---
   return(RGBToColor(R1,G1,B1));
  }
//+------------------------------------------------------------------+
//| Blending two colors considering the transparency of color on top |
//+------------------------------------------------------------------+
color CColors::BlendColors(const uint lower_color,const uint upper_color)
  {
   double r1=0,g1=0,b1=0;
   double r2=0,g2=0,b2=0,alpha=0;
   double r3=0,g3=0,b3=0;
//--- Convert the colors in ARGB format
   uint pixel_color=::ColorToARGB(upper_color);
//--- Get the components of the lower and upper colors
   ColorToRGB(lower_color,r1,g1,b1);
   ColorToRGB(pixel_color,r2,g2,b2);
//--- Get the transparency percentage from 0.00 to 1.00
   alpha=GetA(upper_color)/255.0;
//--- If there is transparency
   if(alpha<1.0)
     {
      //--- Blend the components taking the alpha channel into account
      r3=(r1*(1-alpha))+(r2*alpha);
      g3=(g1*(1-alpha))+(g2*alpha);
      b3=(b1*(1-alpha))+(b2*alpha);
      //--- Adjustment of the obtained values
      r3=(r3>255)? 255 : r3;
      g3=(g3>255)? 255 : g3;
      b3=(b3>255)? 255 : b3;
     }
   else
     {
      r3=r2;
      g3=g2;
      b3=b2;
     }
//--- Combine the obtained components and return the color
   return(RGBToColor(r3,g3,b3));
  }
//+------------------------------------------------------------------+
//| Getting an array of the specified size with a color gradient     |
//+------------------------------------------------------------------+
void CColors::Gradient(color &aColors[],   // List of colors
                       color &aOut[],      // Return array
                       int   aOutCount,    // Setting the size of the return array
                       bool  aCycle=false) // Closed-loop cycle. Return array ends with the same color as it starts with
  {
   ::ArrayResize(aOut,aOutCount);
//---
   int    InCount =::ArraySize(aColors)+aCycle;
   int    PrevJ   =0;
   int    nci     =0;
   double K       =0.0;
//---
   for(int i=1; i<InCount; i++)
     {
      int J=(aOutCount-1)*i/(InCount-1);
      //---
      for(int j=PrevJ; j<=J; j++)
        {
         if(aCycle && i==InCount-1)
           {
            nci =0;
            K   =1.0*(j-PrevJ)/(J-PrevJ+1);
           }
         else
           {
            nci =i;
            K   =1.0*(j-PrevJ)/(J-PrevJ);
           }
         aOut[j]=MixColors(aColors[i-1],aColors[nci],K);
        }
      PrevJ=J;
     }
  }
//+------------------------------------------------------------------+
//| One more variant of conversion of RGB into XYZ and               |
//| corresponding conversion of XYZ into RGB                         |
//+------------------------------------------------------------------+
void CColors::RGBtoXYZsimple(double aR,double aG,double aB,double &oX,double &oY,double &oZ)
  {
   aR/=255;
   aG/=255;
   aB/=255;
   aR*=100;
   aG*=100;
   aB*=100;
//---
   oX=0.431*aR+0.342*aG+0.178*aB;
   oY=0.222*aR+0.707*aG+0.071*aB;
   oZ=0.020*aR+0.130*aG+0.939*aB;
  }
//+------------------------------------------------------------------+
//| XYZtoRGBsimple                                                   |
//+------------------------------------------------------------------+
void CColors::XYZtoRGBsimple(const double aX,const double aY,const double aZ,double &oR,double &oG,double &oB)
  {
   oR=3.063*aX-1.393*aY-0.476*aZ;
   oG=-0.969*aX+1.876*aY+0.042*aZ;
   oB=0.068*aX-0.229*aY+1.069*aZ;
  }
//+------------------------------------------------------------------+
//| Negative color                                                   |
//+------------------------------------------------------------------+
color CColors::Negative(const color aColor)
  {
   double R=0.0,G=0.0,B=0.0;
   ColorToRGB(aColor,R,G,B);
//---
   return(RGBToColor(255-R,255-G,255-B));
  }
//+------------------------------------------------------------------+
//| Search for the most similar color                                |
//| in the set of standard colors of the terminal                    |
//+------------------------------------------------------------------+
color CColors::StandardColor(const color aColor,int &aIndex)
  {
   color m_c[]=
     {
      clrBlack,clrDarkGreen,clrDarkSlateGray,clrOlive,clrGreen,clrTeal,clrNavy,clrPurple,clrMaroon,clrIndigo,
      clrMidnightBlue,clrDarkBlue,clrDarkOliveGreen,clrSaddleBrown,clrForestGreen,clrOliveDrab,clrSeaGreen,
      clrDarkGoldenrod,clrDarkSlateBlue,clrSienna,clrMediumBlue,clrBrown,clrDarkTurquoise,clrDimGray,
      clrLightSeaGreen,clrDarkViolet,clrFireBrick,clrMediumVioletRed,clrMediumSeaGreen,clrChocolate,clrCrimson,
      clrSteelBlue,clrGoldenrod,clrMediumSpringGreen,clrLawnGreen,clrCadetBlue,clrDarkOrchid,clrYellowGreen,
      clrLimeGreen,clrOrangeRed,clrDarkOrange,clrOrange,clrGold,clrYellow,clrChartreuse,clrLime,clrSpringGreen,
      clrAqua,clrDeepSkyBlue,clrBlue,clrFuchsia,clrRed,clrGray,clrSlateGray,clrPeru,clrBlueViolet,clrLightSlateGray,
      clrDeepPink,clrMediumTurquoise,clrDodgerBlue,clrTurquoise,clrRoyalBlue,clrSlateBlue,clrDarkKhaki,clrIndianRed,
      clrMediumOrchid,clrGreenYellow,clrMediumAquamarine,clrDarkSeaGreen,clrTomato,clrRosyBrown,clrOrchid,
      clrMediumPurple,clrPaleVioletRed,clrCoral,clrCornflowerBlue,clrDarkGray,clrSandyBrown,clrMediumSlateBlue,
      clrTan,clrDarkSalmon,clrBurlyWood,clrHotPink,clrSalmon,clrViolet,clrLightCoral,clrSkyBlue,clrLightSalmon,
      clrPlum,clrKhaki,clrLightGreen,clrAquamarine,clrSilver,clrLightSkyBlue,clrLightSteelBlue,clrLightBlue,
      clrPaleGreen,clrThistle,clrPowderBlue,clrPaleGoldenrod,clrPaleTurquoise,clrLightGray,clrWheat,clrNavajoWhite,
      clrMoccasin,clrLightPink,clrGainsboro,clrPeachPuff,clrPink,clrBisque,clrLightGoldenrod,clrBlanchedAlmond,
      clrLemonChiffon,clrBeige,clrAntiqueWhite,clrPapayaWhip,clrCornsilk,clrLightYellow,clrLightCyan,clrLinen,
      clrLavender,clrMistyRose,clrOldLace,clrWhiteSmoke,clrSeashell,clrIvory,clrHoneydew,clrAliceBlue,clrLavenderBlush,
      clrMintCream,clrSnow,clrWhite,clrDarkCyan,clrDarkRed,clrDarkMagenta,clrAzure,clrGhostWhite,clrFloralWhite
     };
//---
   double m_rv=0.0,m_gv=0.0,m_bv=0.0;
//---
   ColorToRGB(aColor,m_rv,m_gv,m_bv);
//---
   double m_md=0.3*::pow(255,2)+0.59*::pow(255,2)+0.11*::pow(255,2)+1;
   aIndex=0;
//---
   for(int i=0; i<138; i++)
     {
      double m_d=0.3*::pow(GetR(m_c[i])-m_rv,2)+0.59*::pow(GetG(m_c[i])-m_gv,2)+0.11*::pow(GetB(m_c[i])-m_bv,2);
      //---
      if(m_d<m_md)
        {
         m_md   =m_d;
         aIndex =i;
        }
     }
//---
   return(m_c[aIndex]);
  }
//+------------------------------------------------------------------+
//| Conversion into gray color                                       |
//+------------------------------------------------------------------+
double CColors::RGBtoGray(double aR,double aG,double aB)
  {
   aR/=255;
   aG/=255;
   aB/=255;
//---
   aR=::pow(aR,2.2);
   aG=::pow(aG,2.2);
   aB=::pow(aB,2.2);
//---
   double rY=0.21*aR+0.72*aG+0.07*aB;
   rY=::pow(rY,1.0/2.2);
//---
   return(rY);
  }
//+------------------------------------------------------------------+
//| Simple conversion into gray color                                |
//+------------------------------------------------------------------+
double CColors::RGBtoGraySimple(double aR,double aG,double aB)
  {
   aR/=255;
   aG/=255;
   aB/=255;
   double rY=0.3*aR+0.59*aG+0.11*aB;
//---
   return(rY);
  }
//+------------------------------------------------------------------+
