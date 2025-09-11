import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favourites/favourite_provider_recipe_widget.dart';
import 'firebase_authentication/firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),

      ],
      child: MyApp(),
    ),
  );
}

// import 'package:flutter/material.dart';
//
// import 'custom/banner_section.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool isDark = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light().copyWith(
//         scaffoldBackgroundColor: Colors.white,
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Colors.black),
//         ),
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.black,
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Colors.white),
//         ),
//       ),
//       themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
//       home: HomeScreen(
//         isDark: isDark,
//         onToggleTheme: () {
//           setState(() {
//             isDark = !isDark;
//           });
//         },
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   final bool isDark;
//   final VoidCallback onToggleTheme;
//
//   const HomeScreen({
//     super.key,
//     required this.isDark,
//     required this.onToggleTheme,
//   });
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   int selectedCategory = -1;
//
//   // بيانات الوصفات
//   final List<Map<String, dynamic>> recipes = [
//     {
//       "name": "Pasta with Cheese",
//       "time": "20 min",
//       "ingredients": "Pasta, Cheese, Milk",
//       "image": "https://picsum.photos/200/150?1",
//       "isFav": false
//     },
//     {
//       "name": "Grilled Chicken",
//       "time": "40 min",
//       "ingredients": "Chicken, Spices, Oil",
//       "image": "https://picsum.photos/200/150?2",
//       "isFav": false
//     },
//     {
//       "name": "Salad Bowl",
//       "time": "10 min",
//       "ingredients": "Lettuce, Tomato, Cucumber",
//       "image": "https://picsum.photos/200/150?3",
//       "isFav": false
//     },
//     {
//       "name": "Pizza",
//       "time": "30 min",
//       "ingredients": "Dough, Cheese, Tomato",
//       "image": "https://picsum.photos/200/150?4",
//       "isFav": false
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Color primaryColor = const Color(0xFF48A6A7);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor, // بيتغير مع الوضع
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: Icon(
//               widget.isDark ? Icons.nights_stay : Icons.wb_sunny,
//               color: Theme.of(context).iconTheme.color, // بيتغير حسب الثيم
//             ),
//             onPressed: widget.onToggleTheme,
//           ),
//         ],
//
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.isDark ? "Good Night," : "Good Morning,",
//               style: TextStyle(
//                 color: Theme.of(context).textTheme.bodyMedium?.color, // بيتغير
//                 fontSize: 16,
//               ),
//             ),
//             Text(
//               "Tasneam",
//               style: TextStyle(
//                 color: Theme.of(context).textTheme.bodyMedium?.color, // بيتغير
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Featured
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Featured",
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             BannerSection(),
//             const SizedBox(height: 20),
//
//             // Category
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Category",
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text("See All", style: TextStyle(color: primaryColor)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Wrap(
//               spacing: 8,
//               children: List.generate(3, (index) {
//                 final categories = ["Breakfast", "Lunch", "Dinner"];
//                 bool isSelected = selectedCategory == index;
//                 return ChoiceChip(
//                   label: Text(categories[index]),
//                   selected: isSelected,
//                   selectedColor: primaryColor,
//                   backgroundColor: const Color.fromARGB(255, 223, 223, 223),
//                   labelStyle: TextStyle(
//                     color: isSelected
//                         ? Colors.white
//                         : const Color.fromARGB(255, 0, 0, 0),
//                   ),
//                   onSelected: (_) {
//                     setState(() {
//                       selectedCategory = index;
//                     });
//                   },
//                 );
//               }),
//             ),
//             const SizedBox(height: 20),
//
//             // Popular Recipes (Scroll أفقي)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Popular Recipes",
//                     style:
//                     TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 Text("See All", style: TextStyle(color: primaryColor)),
//               ],
//             ),
//             const SizedBox(height: 10),
//
//             SizedBox(
//               height: 210,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: recipes.length,
//                 separatorBuilder: (context, _) => const SizedBox(width: 12),
//                 itemBuilder: (context, index) {
//                   final recipe = recipes[index];
//                   return SizedBox(
//                     width: 160,
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // صورة + مفضلة
//                           Stack(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(12)),
//                                 child: Image.network(
//                                   recipe["image"],
//                                   height: 100,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 8,
//                                 top: 8,
//                                 child: IconButton(
//                                   icon: Icon(
//                                     recipe["isFav"]
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       recipe["isFav"] = !recipe["isFav"];
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(recipe["name"],
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14)),
//                                 const SizedBox(height: 4),
//                                 Text("⏱ ${recipe["time"]}",
//                                     style: const TextStyle(fontSize: 12)),
//                                 const SizedBox(height: 4),
//                                 Text("🥗 ${recipe["ingredients"]}",
//                                     style: const TextStyle(fontSize: 12)),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: primaryColor,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.notifications), label: "Bell"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
