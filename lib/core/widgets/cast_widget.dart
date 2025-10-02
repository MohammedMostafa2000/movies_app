import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/mainLayout/data/models/cast_data_model.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({
    super.key,
    required this.castDataModel,
  });
  final CastDataModel castDataModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(12),
      alignment: Alignment.center,
      height: 92.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorsManager.black282A28),
      child: Row(
        children: [
          SizedBox(
            height: 70.h,
            width: 70.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: castDataModel.urlSmallImage,
                height: 70.h,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${castDataModel.name}',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Character: ${castDataModel.characterName}',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
