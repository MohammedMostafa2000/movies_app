import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/authentication/data/shared_prefs.dart';
import 'package:movies_app/authentication/presentation/viewModels/login_view_model.dart';
import 'package:movies_app/core/assets_manager.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/core/routes_manager.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/movie_card.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/profile_view_model.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String token;
  late ProfileViewModel profileViewModel;
  late LoginViewModel loginViewModel;

  final List<String> avatarsList = [
    AssetsManager.avatar1,
    AssetsManager.avatar2,
    AssetsManager.avatar3,
    AssetsManager.avatar4,
    AssetsManager.avatar5,
    AssetsManager.avatar6,
    AssetsManager.avatar7,
    AssetsManager.avatar8,
    AssetsManager.avatar9,
  ];

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  Future<void> _loadProfile() async {
    token = await SharedPrefs.getToken();
    if (mounted) {
      final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
      profileVM.getProfileDetails(token: token);
      profileVM.getFavoritesList(token: token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Consumer<ProfileViewModel>(
            builder: (context, viewModel, child) =>
                viewModel.isLoading && viewModel.isFavoritesLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: ColorsManager.orange,
                      ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 400.h,
                            color: ColorsManager.black282A28,
                            child: Column(
                              children: [
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 58.r,
                                          backgroundImage: AssetImage(
                                              avatarsList[(viewModel.user?.avatarId ?? 1) - 1]),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          viewModel.user?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 20.sp),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          '${viewModel.favoritesList.length}',
                                          style: Theme.of(context).textTheme.displayLarge,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          'Wish List',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 20.sp),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          '0',
                                          style: Theme.of(context).textTheme.displayLarge,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          'History',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 20.sp),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 24.h),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomElevatedButton(
                                        titleStyle: Theme.of(context).textTheme.titleMedium,
                                        onPressed: () {},
                                        color: ColorsManager.orange,
                                        title: 'Edit Profile',
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        titleStyle: Theme.of(context).textTheme.labelMedium,
                                        onPressed: () {
                                          SharedPrefs.saveToken('');
                                          Navigator.pushReplacementNamed(
                                              context, RoutesManager.loginView);
                                        },
                                        color: ColorsManager.red,
                                        title: 'Exit',
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 100.h,
                                  color: ColorsManager.black282A28,
                                  child: TabBar(
                                    tabAlignment: TabAlignment.fill,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    dividerHeight: 0,
                                    indicatorColor: ColorsManager.orange,
                                    automaticIndicatorColorAdjustment: false,
                                    isScrollable: false,
                                    dividerColor: Colors.transparent,
                                    labelColor: ColorsManager.orange,
                                    unselectedLabelColor: ColorsManager.white,
                                    labelStyle: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    unselectedLabelStyle: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    tabs: [
                                      Tab(
                                        height: 100.h,
                                        text: 'Wish List',
                                        icon: Icon(
                                          Icons.list,
                                          size: 35.sp,
                                        ),
                                      ),
                                      Tab(
                                        height: 100.h,
                                        text: 'History',
                                        icon: Icon(
                                          Icons.folder,
                                          size: 35.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                viewModel.favoritesList.isEmpty
                                    ? Center(child: Text('No favorites found'))
                                    : GridView.builder(
                                        padding: REdgeInsets.all(12),
                                        itemCount: viewModel.favoritesList.length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.65,
                                          crossAxisSpacing: 12.w,
                                          mainAxisSpacing: 12.h,
                                        ),
                                        itemBuilder: (context, index) => MovieCard(
                                          onTap: () async {
                                            final result = await Navigator.pushNamed(
                                              context,
                                              RoutesManager.movieDetailsView,
                                              arguments: viewModel.favoritesList[index].id,
                                            );

                                            if (result == true) {
                                              viewModel.getFavoritesList(token: token);

                                              setState(() {});
                                            }
                                          },
                                          movieDataModel: viewModel.favoritesList[index],
                                        ),
                                      ),
                                Center(child: Text('History')),
                              ],
                            ),
                          ),
                        ],
                      )),
      ),
    );
  }
}
