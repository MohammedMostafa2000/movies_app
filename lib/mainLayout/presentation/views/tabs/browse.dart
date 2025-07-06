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

  @override
  void initState() {
    browseTabViewModel = Provider.of<BrowseTabViewModel>(context, listen: false);
    browseTabViewModel.getMoviesBasedOnGenre(genre: movieCategories[0]);
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<BrowseTabViewModel>(
            builder: (context, viewModel, child) => Column(
              children: [
                DefaultTabController(
                  length: movieCategories.length,
                  child: TabBar(
                    padding: REdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    physics: BouncingScrollPhysics(),
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      viewModel.getMoviesBasedOnGenre(genre: movieCategories[selectedIndex]);
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
                            color: isSelected ? ColorsManager.orange : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorsManager.orange,
                              width: 2.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            movieCategories[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                viewModel.isLoading
                    ? SizedBox(
                        height: 700.h,
                        child: Center(
                          child: CircularProgressIndicator(color: ColorsManager.orange),
                        ),
                      )
                    : CustomGridViewBuilder(
                        count: viewModel.genreMoviesList.length,
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        itemBuilder: (context, index) {
                          return MovieCard(movieDataModel: viewModel.genreMoviesList[index]);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
