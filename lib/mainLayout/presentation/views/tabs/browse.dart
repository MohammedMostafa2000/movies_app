import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/widgets/custom_grid_view_builder.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/browse_tab_view_model.dart';
import 'package:provider/provider.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  late BrowseTabViewModel browseTabViewModel;
  final List<String> movieCategories = [
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

  int selectedIndex = 0;
  String currentGenre = '';
  int pageNumber = 1;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    browseTabViewModel =
        Provider.of<BrowseTabViewModel>(context, listen: false);
    currentGenre = movieCategories[0];
    browseTabViewModel.getMoviesBasedOnGenre(
        genre: currentGenre, page: pageNumber);
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0 &&
          !browseTabViewModel.isLoading) {
        pageNumber++;
        browseTabViewModel.getMoviesBasedOnGenre(
          genre: currentGenre,
          page: pageNumber,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    browseTabViewModel.genreMoviesList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultTabController(
              length: movieCategories.length,
              child: TabBar(
                padding: REdgeInsets.symmetric(horizontal: 8),
                physics: const BouncingScrollPhysics(),
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    currentGenre = movieCategories[selectedIndex];
                    pageNumber = 1;
                  });

                  browseTabViewModel.genreMoviesList.clear();
                  browseTabViewModel.getMoviesBasedOnGenre(
                    genre: currentGenre,
                    page: pageNumber,
                  );
                },
                isScrollable: true,
                automaticIndicatorColorAdjustment: false,
                tabs: List.generate(
                  movieCategories.length,
                  (index) {
                    final isSelected = index == selectedIndex;
                    return Container(
                      padding: REdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorsManager.orange
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ColorsManager.orange,
                          width: 2.w,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(movieCategories[index]),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Consumer<BrowseTabViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading &&
                      viewModel.genreMoviesList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: ColorsManager.orange),
                    );
                  }
                  return CustomGridViewBuilder(
                    controller: scrollController,
                    padding: REdgeInsets.symmetric(horizontal: 8),
                    count: viewModel.genreMoviesList.length,
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movieDataModel: viewModel.genreMoviesList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
