import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';

import '../../modules/main/view/screens/main_screen.dart';
import '../../modules/main/view/screens/notifications_screen.dart';
import '../../modules/main/view/screens/splash_screen.dart';
import '../../modules/places/view/screens/place_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    print(settings.toString());
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(
            nextScreen: MainScreen(),
            // nextScreen: ConstantsManager.userToken == null
            //     ? const GetStartedScreen()
            //     : const MainScreen(),
          ),
        );
      case Routes.place:
        Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        print(arguments['id']);
        return MaterialPageRoute(builder: (_) => PlaceScreen(placeId: arguments['id']));
      // case Routes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      // case Routes.profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phonelink_erase_rounded),
                      Text('No route defined for ${settings.name}'),
                    ],
                  ),
                )));
    }
  }
}
