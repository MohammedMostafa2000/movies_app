import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/widgets/custom_grid_view_builder.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/search_tab_view_model.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String textFormFieldData = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SearchTabViewModel>(
        builder: (context, viewModel, child) => SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    cursorColor: ColorsManager.white,
                    onChanged: (value) {
                      setState(() {
                        textFormFieldData = value;
                        viewModel.getMoviesBySearch(query: value);
                      });
                    },
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                textFormFieldData.isNotEmpty
                    ? CustomGridViewBuilder(
                        count: viewModel.moviesList.length,
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movieDataModel: viewModel.moviesList[index],
                          );
                        },
                      )
                    : SizedBox(
                        height: 750.h,
                        child: Center(
                          child: Image.asset(
                            AssetsManager.popcorn,
                            height: 124.h,
                          ),
                        ),
                      ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
