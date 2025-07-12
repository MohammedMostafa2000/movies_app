import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';

class GenreWidget extends StatelessWidget {
  const GenreWidget({
    super.key,
    required this.category,
  });
  final String category;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 36.h,
      width: 122.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsManager.black282A28,
      ),
      child: Text(
        category,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

