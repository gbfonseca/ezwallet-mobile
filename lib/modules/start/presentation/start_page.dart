import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

import '../../../utils/ui/colors.dart';
import '../../dashboard/presentation/dashboard_page.dart';
import '../../home/presentation/home_page.dart';
import 'notifiers/start.dart';

class StartPage extends HookWidget {
  final List<Widget> screensList = [HomePage(), DashboardPage()];

  @override
  Widget build(BuildContext context) {
    final state = useListenable(StartNotifier());
    final pageViewController = usePageController();
    return Scaffold(
      backgroundColor: ColorConstants.kBackgroundColor,
      body: PageView(
          onPageChanged: (value) {
            state.selectedIndex = value;
          },
          controller: pageViewController,
          children: [HomePage(), DashboardPage()]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: ColorConstants.kPrimaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/start/add_investment/');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: state.selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 24,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    LineariconsFree.pie_chart,
                    size: 21,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    null,
                    size: 24,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome5.wallet,
                    size: 21,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    size: 24,
                  ),
                  label: ''),
            ],
            selectedItemColor: ColorConstants.kPrimaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              state.onItemTapped(index);
              pageViewController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.easeOut);
            },
          ),
        ),
      ),
    );
  }
}
