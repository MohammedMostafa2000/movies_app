import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/widgets/cast_widget.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_grid_view_builder.dart';
import 'package:movies_app/core/widgets/custom_statistics_widget.dart';
import 'package:movies_app/core/widgets/genre_widget.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/movie_details_view_model.dart';
import 'package:provider/provider.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({
    super.key,
    required this.movieId,
  });
  final int movieId;
  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late MovieDetailsViewModel movieDetailsViewModel;

  @override
  void initState() {
    loadMovieDetails();
    super.initState();
  }

  loadMovieDetails() async {
    movieDetailsViewModel = Provider.of<MovieDetailsViewModel>(context, listen: false);
    movieDetailsViewModel.getMovieDetails(movieId: widget.movieId);
    movieDetailsViewModel.getMovieSuggestions(movieId: widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MovieDetailsViewModel>(
          builder: (context, viewModel, child) => viewModel.isLoading
              ? SizedBox(
                  height: 1000.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.orange,
                    ),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 645.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: viewModel.movie!.largeCoverImage,
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          Container(
                            height: 645.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorsManager.black121312.withValues(alpha: 0.20),
                                  ColorsManager.black121312.withValues(alpha: 1.00),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SafeArea(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: ColorsManager.white,
                                          size: 34.sp,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.bookmark_outlined,
                                          color: ColorsManager.white,
                                          size: 34.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 155.h),
                                Image.asset(
                                  AssetsManager.play,
                                  height: 97.h,
                                ),
                                SizedBox(height: 155.h),
                                Text(
                                  textAlign: TextAlign.center,
                                  viewModel.movie?.titleEnglish ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  '${viewModel.movie?.year}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomElevatedButton(
                            color: ColorsManager.red,
                            title: 'Watch',
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomStatisticsWidget(
                                icon: Icons.favorite,
                                text: viewModel.movie?.likeCount.toString() ?? '',
                              ),
                              CustomStatisticsWidget(
                                icon: Icons.watch_later_rounded,
                                text: viewModel.movie?.runtime.toString() ?? '',
                              ),
                              CustomStatisticsWidget(
                                icon: Icons.star_rate_rounded,
                                text: viewModel.movie?.rating.toString() ?? '',
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          CustomTitle(
                            title: 'Screen Shots',
                          ),
                          SizedBox(height: 16.h),
                          CustomScreenshotFrame(
                            imageUrl: viewModel.movie?.largeScreenshotImage1 ?? '',
                          ),
                          SizedBox(height: 12.h),
                          CustomScreenshotFrame(
                            imageUrl: viewModel.movie?.largeScreenshotImage2 ?? '',
                          ),
                          SizedBox(height: 12.h),
                          CustomScreenshotFrame(
                            imageUrl: viewModel.movie?.largeScreenshotImage3 ?? '',
                          ),
                          SizedBox(height: 16.h),
                          CustomTitle(
                            title: 'Similar',
                          ),
                          SizedBox(height: 16.h),
                          viewModel.isMovieSuggestionsLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: ColorsManager.orange,
                                  ),
                                )
                              : CustomGridViewBuilder(
                                  padding: EdgeInsets.zero,
                                  count: viewModel.movieSuggestionsList.length,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.70,
                                  itemBuilder: (context, index) => MovieCard(
                                    movieDataModel: viewModel.movieSuggestionsList[index],
                                  ),
                                ),
                          SizedBox(height: 16.h),
                          CustomTitle(
                            title: 'Summary',
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            (viewModel.movie?.descriptionFull.isNotEmpty == true)
                                ? viewModel.movie!.descriptionFull
                                : (viewModel.movie?.descriptionIntro.isNotEmpty == true
                                    ? viewModel.movie!.descriptionIntro
                                    : 'No Summary Available'),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(height: 16.h),
                          CustomTitle(
                            title: 'Cast',
                          ),
                          SizedBox(height: 16.h),
                          ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height: 8.h),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: viewModel.movie!.cast.length,
                            itemBuilder: (context, index) =>
                                CastWidget(castDataModel: viewModel.movie!.cast[index]),
                          ),
                          SizedBox(height: 16.h),
                          CustomTitle(
                            title: 'Genres',
                          ),
                          SizedBox(height: 16.h),
                          GridView.builder(
                            padding: REdgeInsets.only(bottom: 40),
                            itemCount: viewModel.movie!.genres.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 12.h,
                              crossAxisSpacing: 16.w,
                              crossAxisCount: 3,
                              childAspectRatio: 2.5,
                            ),
                            itemBuilder: (context, index) => GenreWidget(
                              category: viewModel.movie!.genres[index],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomScreenshotFrame extends StatelessWidget {
  const CustomScreenshotFrame({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.h),
      child: Image.network(
        imageUrl,
        height: 168.h,
        fit: BoxFit.cover,
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
