import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/get_started_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/login_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/profile_screen.dart';
import 'package:hawi_hub_owner/src/modules/chat/view/screens/chats_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/add_working_hours_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/create_place_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/edit_place_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/place_location_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/share_loaction_screen.dart';

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
      case Routes.createPlace:
        return MaterialPageRoute(builder: (_) => CreatePlaceScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.pickLocation:
        return MaterialPageRoute(builder: (_) => const PickLocationScreen());
      case Routes.editPlace:
        Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        print(arguments['id']);
        return MaterialPageRoute(builder: (_) => EditPlaceScreen(placeId: arguments['id']));
      case Routes.profile:
        Owner arguments = settings.arguments as Owner;
        return MaterialPageRoute(builder: (_) => ProfileScreen(owner: arguments));
      case Routes.request:
        Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => RequestScreen(request: arguments['request']));
      case Routes.placeLocation:
        Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PlaceLocationScreen(
                  location: arguments['location'],
                ));
      case Routes.addWorkingHours:
        return MaterialPageRoute(builder: (_) => const AddWorkingHours());
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
