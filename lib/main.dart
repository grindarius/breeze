import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:breeze/constants/colors.dart';
import 'package:breeze/models/habit.dart';
import 'package:breeze/models/habit_type.dart';
import 'package:breeze/router/router.dart' as router;
import 'package:breeze/views/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitTypeAdapter());
  await Hive.openBox<Habit>('habits');

  runApp(const BreezeApp());
}

class BreezeApp extends StatelessWidget {
  const BreezeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breeze',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: maximumPurple,
        primarySwatch: maximumPurpleMaterial,
        scaffoldBackgroundColor: darkGrayMaterial,
        buttonTheme: ButtonThemeData(
          buttonColor: maximumPurple
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: babyPowderWhite, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(color: babyPowderWhite, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: babyPowderWhite),
          bodyText1: TextStyle(color: babyPowderWhite, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: babyPowderWhite)
        )
      ),
      initialRoute: HomePage.route,
      onGenerateRoute: router.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
