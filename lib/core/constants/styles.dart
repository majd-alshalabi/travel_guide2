import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Insets {
  static double gutterScale = 1;

  static double widthScale = 1.w;
  static double heightScale = 1.h;

  /// Dynamic insets, may get scaled with the device size
  static double mGutter = m * gutterScale;

  static double lGutter = l * gutterScale;

  static const double defaultSm = 6 * 1;
  static const double defaultXs = 2 * 1;
  static const double defaultM = 12 * 1;
  static const double defaultL = 24 * 1;
  static const double defaultXL = 36 * 1;
  static const double defaultXXL = 64 * 1;

  static double xs = 2 * widthScale;

  static double s = 4 * widthScale;

  static double sm = 6 * widthScale;

  static double m = 12 * widthScale;

  static double xm = 18 * widthScale;

  static double l = 24 * widthScale;

  static double xl = 36 * widthScale;

  static double xxl = 64 * widthScale;

  static double xsHeight = 2 * heightScale;

  static double smHeight = 6 * heightScale;

  static double mHeight = 12 * heightScale;

  static double xmHeight = 18 * heightScale;

  static double lHeight = 24 * heightScale;

  static double xlHeight = 36 * heightScale;

  static double xxlHeight = 64 * heightScale;

  static double offsetScale = 1.w;
  static double heightOffsetScale = 1.h;

  // Regular paddings

  static double get med => 12 * widthScale;

  static double get lg => 16 * widthScale;

  static double get medHeight => 12 * heightScale;

  static double get lgHeight => 16 * heightScale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static const double btn = s5;
  static const double sm = 10;
  static const double xsm = 5;
  static const double dialog = 12;

  /// Xs
  static const double s3 = 3;

  static BorderRadius get s3Border => BorderRadius.all(s3Radius);

  static Radius get s3Radius => const Radius.circular(s3);

  /// Small
  static const double s5 = 5;

  static BorderRadius get s5Border => BorderRadius.all(s5Radius);

  static Radius get s5Radius => const Radius.circular(s5);

  /// Medium
  static const double s8 = 8;

  static const BorderRadius s8Border = BorderRadius.all(s8Radius);

  static const Radius s8Radius = Radius.circular(s8);

  /// Large
  static const double s10 = 10;

  static BorderRadius get s10Border => BorderRadius.all(s10Radius);

  static Radius get s10Radius => const Radius.circular(s10);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);
  static const double med = 15;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 20;
  static const double xlg = 25;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);
  static const double xl = 30;
  static const double xll = 40;
  static const double xxl = 60;
}

class StylesText {
  static TextStyle textStyleForButton = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      fontFamily: "DMSans-Regular",
      color: Color(0xffFFFFFF));
  static TextStyle textStyleForTitle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.0,
    fontFamily: "DMSans-Regular",
  );
  static TextStyle textStyleForDescription = TextStyle();
  static TextStyle textStyleForTextTilte = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontFamily: "DMSans-Regular",
    fontSize: 22.0,
  );
  static TextStyle defaultTextStyle = const TextStyle(
    color: Colors.grey,
    fontFamily: "DMSans-Regular",
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
  );
  static TextStyle textStyleForTextFormTilte = const TextStyle(
    color: Colors.black,
    fontFamily: "DMSans-Regular",
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
  );
}
