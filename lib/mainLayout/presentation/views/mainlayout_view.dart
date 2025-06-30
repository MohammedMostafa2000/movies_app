import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/mainLayout/presentation/views/tabs/home.dart';

class MainlayoutView extends StatefulWidget {
  const MainlayoutView({super.key});

  @override
  State<MainlayoutView> createState() => _MainlayoutViewState();
}

class _MainlayoutViewState extends State<MainlayoutView> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 8,
          ),
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
    );
  }
}
