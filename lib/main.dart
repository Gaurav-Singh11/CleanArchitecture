import 'package:flutter/material.dart';
import 'package:tdd_flutter/core/res/colors.dart';
import 'package:tdd_flutter/core/res/fonts.dart';
import 'package:tdd_flutter/core/services/router.dart';
import 'package:tdd_flutter/src/on_boarding/presentation/on_boarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
        fontFamily: Fonts.poppins,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
      onGenerateRoute: generateRoute,
      // routes: {
      //   OnBoardingScreen.routeName : (_) => const OnBoardingScreen(),
      // },
    );
  }
}
