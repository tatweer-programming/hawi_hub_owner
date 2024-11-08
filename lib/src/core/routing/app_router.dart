import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/confirm_email_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/get_started_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/login_screen.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/screens/profile_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/screens/questions_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/screens/terms_conditions_screen.dart';
import 'package:hawi_hub_owner/src/modules/main/view/screens/view_image_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/add_booking_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/add_working_hours_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/create_place_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/edit_place_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/edit_working_hours_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/future_bookings_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/place_reviews.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/request_screen.dart';
import 'package:hawi_hub_owner/src/modules/places/view/screens/share_loaction_screen.dart';
import '../../modules/main/view/screens/main_screen.dart';
import '../../modules/main/view/screens/notifications_screen.dart';
import '../../modules/main/view/screens/splash_screen.dart';
import '../../modules/places/view/screens/place_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    //print(settings.toString());
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(
            // nextScreen: MainScreen(),
            nextScreen: ConstantsManager.userId == null
                ? (ConstantsManager.isFirstTime == true ||
                        ConstantsManager.isFirstTime == null
                    ? const GetStartedScreen()
                    : const LoginScreen())
                : const MainScreen(),
          ),
        );
      case Routes.place:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        //print(arguments['id']);
        return MaterialPageRoute(
            builder: (_) => PlaceScreen(placeId: arguments['id']));
      // case Routes.login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.createPlace:
        return MaterialPageRoute(builder: (_) => const CreatePlaceScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.pickLocation:
        return MaterialPageRoute(builder: (_) => const PickLocationScreen());
      case Routes.editPlace:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        //print(arguments['id']);
        return MaterialPageRoute(
            builder: (_) => EditPlaceScreen(placeId: arguments['id']));
      case Routes.profile:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ProfileScreen(id: arguments['id']));
      case Routes.request:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => RequestScreen(request: arguments['request']));
      case Routes.addBooking:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => AddBookingScreen(
                  placeId: arguments['id'],
                ));
      // case Routes.placeLocation:
      //   Map<String, dynamic> arguments =
      //       settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => PlaceLocationScreen(
      //             location: arguments['location'],
      //           ));
      case Routes.addWorkingHours:
        return MaterialPageRoute(builder: (_) => const AddWorkingHours());
      case Routes.editWorkingHours:
        return MaterialPageRoute(
            builder: (_) => const EditWorkingHoursScreen());
      case Routes.questions:
        return MaterialPageRoute(builder: (_) => const QuestionsScreen());
      case Routes.termsAndCondition:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());
      case Routes.placeFeedbacks:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PlaceFeedbacksScreen(
                  id: arguments['id'],
                ));

      case Routes.confirmEmail:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ConfirmEmailScreen(bloc: arguments['bloc']));
      case Routes.viewImages:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => FullScreenImageGallery(
                  imageUrls: arguments['imageUrls'],
                  initialIndex: arguments['index'],
                ));
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
