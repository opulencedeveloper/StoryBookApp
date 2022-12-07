import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './screens/intro_screen.dart';
import './screens/book_details_screen.dart';
import './provider/books.dart';
import './provider/favorite_book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Books(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FavoriteBooks(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Hello World',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color(0xff15133C),
          scaffoldBackgroundColor: Colors.grey[100],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xffEDEDED),
            // foregroundColor: Colors.greenAccent,
            // hoverColor: Colors.redAccent,
            //splashColor: Colors.tealAccent,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xffEC994B),
            secondary: const Color(0xffFFFFFF),
          ),
        ),
        // A widget which will be started on application startup
        home: IntroScreen(), //TabsScreen(), //BookDetailsScreen(), //////TabsScreen(),
        routes: {
          BookDetailsScreen.routeName: (ctx) => BookDetailsScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen()
        },
      ),
    );
  }
}
