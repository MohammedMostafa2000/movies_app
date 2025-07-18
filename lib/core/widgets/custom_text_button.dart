import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
