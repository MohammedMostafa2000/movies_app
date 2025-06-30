import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/movie.jpg'),
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          height: 350.h,
          width: 234.w,
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: REdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsManager.black121312.withAlpha((0.71 * 255).round()),
              borderRadius: BorderRadius.circular(12.r),
            ),
            height: 36.h,
            width: 76.w,
            child: Text(
              '7.7 ⭐',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}