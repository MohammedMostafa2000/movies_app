import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/widgets/movie_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> carouselList = [
    MovieCard(),
    MovieCard(),
    MovieCard(),
    MovieCard(),
    MovieCard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 645.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.3,
              fit: BoxFit.fill,
              image: AssetImage('assets/images/movie.jpg'),
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AssetsManager.availableNow,
                    height: 94.h,
                    width: 266.w,
                  ),
                  SizedBox(
                    height: 350.h,
                    width: double.infinity,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.infinity,
                        enlargeCenterPage: true,
                        viewportFraction: 0.62,
                        aspectRatio: 1,
                      ),
                      items: carouselList,
                    ),
                  ),
                  Image.asset(
                    AssetsManager.watchNow,
                    height: 146.h,
                    width: 330.w,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Action',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'See More  ->',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16.w,
                      ),
                      itemBuilder: (context, index) => SizedBox(
                        height: 220.h,
                        width: 146.w,
                        child: MovieCard(),
                      ),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
