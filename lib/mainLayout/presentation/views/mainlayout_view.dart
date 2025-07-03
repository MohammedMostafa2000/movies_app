import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/home_tab_view_model.dart';
import 'package:movies_app/mainLayout/presentation/views/tabs/home.dart';
import 'package:movies_app/mainLayout/presentation/views/tabs/search.dart';
import 'package:provider/provider.dart';

class MainlayoutView extends StatefulWidget {
  const MainlayoutView({super.key});

  @override
  State<MainlayoutView> createState() => _MainlayoutViewState();
}

class _MainlayoutViewState extends State<MainlayoutView> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    Home(),
    Search(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeTabViewModel()),
      ],
      child: Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                iconSize: 30.sp,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.explore), label: ''),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
