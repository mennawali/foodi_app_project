
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodi_app_project/app_colors.dart';
import 'package:foodi_app_project/pages/home_page.dart';
import 'package:foodi_app_project/pages/profile.dart';
import 'package:foodi_app_project/pages/recipes/tab_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NavItem.navItems[_selectedIndex].page,
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // لون الظل
              spreadRadius: 2, // مدى الانتشار
              blurRadius: 5,   // درجة التمويه
              offset: const Offset(0, 3), // اتجاه الظل (x, y)
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: NavItem.navItems
                  .map(
                    (e) => Expanded(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = NavItem.navItems.indexOf(e);
                      });
                    },
                    icon: e.icon ,
                      color: _selectedIndex == NavItem.navItems.indexOf(e)
                          ? AppColors.primaryColor
                          : AppColors.primaryColor,

                  ),
                ),
              )
                  .toList(),
            ),

            Row(
              children: NavItem.navItems
                  .map(
                    (e) => Expanded(
                  child: AnimatedContainer(margin: EdgeInsets.symmetric(horizontal: 50),
                    height: 6,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: _selectedIndex == NavItem.navItems.indexOf(e)
                          ? AppColors.primaryColor
                          :  Colors.white,

                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }


}

class NavItem {
  final String title;
  final Widget icon;
  final Widget page;

  NavItem({required this.title, required this.icon, required this.page});

  static List<NavItem> navItems = [
    NavItem(title: 'Home', icon: Icon(Icons.home), page: HomePage()),
    NavItem(title: 'Recipes', icon: Icon(Icons.restaurant), page: TabWidget()),
    NavItem(title: 'Profile', icon: Icon(Icons.person,), page: Profile()),
  ];
}
