import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/routes_manager.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    super.key,
    this.movieDataModel,
    this.onTap,
  });
  final MovieDataModel? movieDataModel;
  final VoidCallback? onTap;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ??
          () {
            Navigator.pushNamed(
              context,
              RoutesManager.movieDetailsView,
              arguments: widget.movieDataModel!.id,
            );
          },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: CachedNetworkImage(
              imageUrl:
                  (widget.movieDataModel?.largeCoverImage.trim().isNotEmpty ??
                          false)
                      ? widget.movieDataModel!.largeCoverImage
                      : widget.movieDataModel!.mediumCoverImage,
              height: 350.h,
              width: 234.w,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                      child: CircularProgressIndicator(
                color: ColorsManager.orange,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: REdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    ColorsManager.black121312.withAlpha((0.71 * 255).round()),
                borderRadius: BorderRadius.circular(12.r),
              ),
              height: 36.h,
              width: 76.w,
              child: Text(
                '${widget.movieDataModel?.rating ?? 0} ⭐',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
