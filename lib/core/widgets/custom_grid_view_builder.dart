import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridViewBuilder extends StatelessWidget {
  const CustomGridViewBuilder({
    super.key,
    required this.count,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.itemBuilder,
    required this.padding,
    this.controller,
  });
  final int count;
  final int crossAxisCount;
  final double childAspectRatio;
  final Widget? Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: false,
      itemCount: count,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
