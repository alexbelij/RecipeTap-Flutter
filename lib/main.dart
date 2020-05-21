import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipetap/jump_screens/aww_snap_screen.dart';
import 'package:recipetap/pages/home_screen.dart';
import 'package:recipetap/pages/search_screen.dart';
import 'package:recipetap/utility/route_generator.dart';
import 'package:recipetap/widgets/loading_spinner.dart';

import 'pages/recipe_view_page.dart';

void main() {
  runApp(MyApp());
}

// TODO: Handle Text Overflows Everywhere in the app

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // primaryColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30,
          ),
          headline3: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(),

      routes: {
        '/':
            // (context) => LoadingSpinner(),
            (context) => HomeScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        RecipeViewPage.routeName: (context) => RecipeViewPage(),
      },
      // onGenerateRoute: (settings) {
      //   return RouteGenerator.generateRoute(settings);
      // },
      onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => AwwSnapScreen()),
    );
  }
}
