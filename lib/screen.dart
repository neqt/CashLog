import 'package:cashlog/pages/budget_page.dart';
import 'package:cashlog/pages/home_page.dart';
import 'package:cashlog/pages/split_page.dart';
import 'package:cashlog/pages/stat_page.dart';
import 'package:cashlog/utils/constants.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var currentIndex = 0;

  Widget buildPageContent(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const BudgetPage();
      case 2:
        return const SplitPage();
      case 3:
        return const StatPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageContent(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: primaryDark,
        selectedFontSize: 12,
        unselectedItemColor: secondaryLight,
        backgroundColor: primaryLight,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.donut_large_rounded),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toll_rounded),
            label: 'Split',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Stat',
          ),
        ],
      ),
    );
  }
}
