import 'package:flutter/material.dart';

class Dimens {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double statusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomNavigationBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  // Hàm tính toán tỷ lệ ngang dựa trên thiết bị tham chiếu có chiều rộng 375px
  static double horizontalScale(double value, BuildContext context) =>
      (value / 375) * MediaQuery.of(context).size.width;

  // Hàm tính toán tỷ lệ dọc dựa trên thiết bị tham chiếu có chiều cao 812px
  static double verticalScale(double value, BuildContext context) =>
      (value / 812) * MediaQuery.of(context).size.height;

  // Screen height available (loại bỏ padding top và bottom)
  static double screenHeightAvailable(BuildContext context) =>
      MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      MediaQuery.of(context).padding.bottom;

  // Common paddings
  static double commonBottomPadding(BuildContext context) =>
      verticalScale(16, context);

  static double commonHeaderPadding(BuildContext context) =>
      statusBarHeight(context) + verticalScale(16, context);
}

// Extension Methods để đơn giản hóa việc sử dụng Dimens
extension DimensExtension on BuildContext {
  // Horizontal scale
  double w(double value) => Dimens.horizontalScale(value, this);

  // Vertical scale
  double h(double value) => Dimens.verticalScale(value, this);

  // Font scale
  double font(double value) => Dimens.horizontalScale(value, this);

  // Radius scale
  double radius(double value) => Dimens.horizontalScale(value, this);

  // Screen dimensions
  double get screenWidth => Dimens.screenWidth(this);
  double get screenHeight => Dimens.screenHeight(this);
  double get statusBarHeight => Dimens.statusBarHeight(this);
  double get bottomNavigationBarHeight =>
      Dimens.bottomNavigationBarHeight(this);
  double get screenHeightAvailable => Dimens.screenHeightAvailable(this);

  // Common paddings
  double get commonBottomPadding => Dimens.commonBottomPadding(this);
  double get commonHeaderPadding => Dimens.commonHeaderPadding(this);
}
