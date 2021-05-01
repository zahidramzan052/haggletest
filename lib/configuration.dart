import 'package:flutter/material.dart';

const PrimaryColor = Color(0xFF301e6b);
const buttonColor = Color(0xFFffc175);
Color accentColor = Colors.white.withOpacity(0.95);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;
  static String baseUrl =
      "https://hagglex-backend-staging.herokuapp.com/graphql";

  static double xlargText = 30;
  static double largText = 25;
  static double meduim2Text = 15;
  static double meduimText = 12;
  static double smallText = 11;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static double getScreenHeight() {
    double screenHeight = SizeConfig.screenHeight;
    return screenHeight;
    //
  }

  static double getScreenWidth() {
    double screenWidth = SizeConfig.screenWidth;
    return screenWidth;
  }
}
