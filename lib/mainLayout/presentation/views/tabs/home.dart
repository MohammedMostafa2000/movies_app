import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/home_tab_view_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String movieCategory = 'Action';
  List<String> movieCategories = [
    'Action',
    'Adventure',
    'Animation',
    'Anime',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'Western',
  ];
  int _selectedIndex = 0;
  late HomeTabViewModel homeTabViewModel;
  bool isMoreTapped = false;
  String toggleLabel = 'See More  ->';

  @override
  void initState() {
    super.initState();
    homeTabViewModel = Provider.of<HomeTabViewModel>(context, listen: false);
    homeTabViewModel.getAvailableMovies();
    homeTabViewModel.getMoviesBasedOnGenre(
        genre: movieCategories[homeTabViewModel.categoryIndex]);
    movieCategory = movieCategories[homeTabViewModel.categoryIndex];
  }

  @override
  void dispose() {
    super.dispose();
    homeTabViewModel.incrementCategoryIndex();
    homeTabViewModel.genreMoviesList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabViewModel>(
        builder: (context, viewModel, child) => viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: ColorsManager.orange,
              ))
            : Stack(children: [
                Container(
                  height: 645.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.3,
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(homeTabViewModel
                                .availableMoviesList.isNotEmpty
                            ? homeTabViewModel
                                .availableMoviesList[_selectedIndex]
                                .largeCoverImage
                            : 'https://n-lightenment.com/wp-content/uploads/2015/10/movie-night11.jpg')),
                  ),
                ),
                SafeArea(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Image.asset(
                          AssetsManager.availableNow,
                          height: 94.h,
                          width: 266.w,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 350.h,
                          width: double.infinity,
                          child: CarouselSlider(
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                height: double.infinity,
                                enlargeCenterPage: true,
                                viewportFraction: 0.62,
                                aspectRatio: 1,
                              ),
                              items: viewModel.availableMoviesList
                                  .map(
                                    (movieDataModel) => MovieCard(
                                      movieDataModel: movieDataModel,
                                    ),
                                  )
                                  .toList()),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Image.asset(
                          AssetsManager.watchNow,
                          height: 146.h,
                          width: 330.w,
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                movieCategory,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isMoreTapped = !isMoreTapped;
                                    toggleLabel = isMoreTapped
                                        ? 'See Less'
                                        : 'See More  ->';
                                  });
                                },
                                child: Text(
                                  toggleLabel,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                      isMoreTapped
                          ? SliverToBoxAdapter(
                              child: GridView.builder(
                                padding: REdgeInsets.symmetric(horizontal: 8),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: viewModel.genreMoviesList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.h,
                                  crossAxisSpacing: 8.w,
                                  childAspectRatio: 0.6,
                                ),
                                itemBuilder: (context, index) => MovieCard(
                                  movieDataModel:
                                      viewModel.genreMoviesList[index],
                                ),
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: SizedBox(
                                height: 220,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: REdgeInsets.symmetric(horizontal: 8),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 16.w),
                                  itemCount:
                                      viewModel.genreMoviesList.length > 10
                                          ? 10
                                          : viewModel.genreMoviesList.length,
                                  itemBuilder: (context, index) => SizedBox(
                                    height: 220.h,
                                    width: 146.w,
                                    child: MovieCard(
                                      movieDataModel:
                                          viewModel.genreMoviesList[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                    ],
                  ),
                ),
              ]));
  }
}
