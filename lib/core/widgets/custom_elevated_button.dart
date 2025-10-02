import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.color,
    required this.title,
    this.titleStyle,
    this.onPressed,
  });
  final Color color;
  final String title;
  final TextStyle? titleStyle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(double.infinity, 58.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: titleStyle, // Theme.of(context).textTheme.labelMedium!.copyWith(
        //       fontWeight: FontWeight.bold,
        //     ),
      ),
    );
  }
}
