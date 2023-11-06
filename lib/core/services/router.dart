import 'package:flutter/material.dart';
import 'package:tdd_flutter/src/on_boarding/presentation/on_boarding_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
  }
}


PageRouteBuilder<dynamic> _pageBuilder(Widget Function(BuildContext) page,
    {required RouteSettings settings,}){


}