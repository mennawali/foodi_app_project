import 'package:flutter/material.dart';
import 'package:foodi_app_project/pages/recipes/recipes.dart';
import 'package:foodi_app_project/pages/recipes/tab_item.dart';

class TabWidget extends StatefulWidget{
  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  List<String> categories = ["breakfast", "lunch", "dinner",  "dessert", "salad","drink"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(

          length:categories.length,
          child: Column(
            children: [
              TabBar(
                  onTap: (index){
                    selectedIndex = index;
                    setState(() {

                    });
                  },
                  isScrollable: true,
                  dividerColor: Colors.transparent ,
                  indicatorColor: Colors.transparent,
                  tabs: categories.map((source)=>
                      TabItem(categoryName: source,
                          isSelected: selectedIndex == categories.indexOf(source)
                      )
                  ).toList()


              ),
              Expanded(child: Recipes( category: categories[selectedIndex],))
            ],
          )),
    );
  }
}