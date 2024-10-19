import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawi_hub_owner/firebase_options.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/routing/app_router.dart';
import 'package:hawi_hub_owner/src/core/routing/routes.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/localization_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/theme_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/chat/bloc/chat_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/data/services/notification_services.dart';
import 'package:hawi_hub_owner/src/modules/payment/bloc/payment_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:sizer/sizer.dart';
import "package:timeago/timeago.dart" as timeago;

class AppManager {
  static Future<void> init() async {
    timeago.setLocaleMessages("ar", timeago.ArMessages());
    WidgetsFlutterBinding.ensureInitialized();
    await CacheHelper.init();
    DioHelper.init();
    ConstantsManager.userId = await CacheHelper.getData(key: 'userId');
    ConstantsManager.isFirstTime = await CacheHelper.getData(key: 'firstTime');
    await LocalizationManager.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificationServices.init();
  }
}

Future<void> main() async {
  await AppManager
      .init(); // حط الكلاس دا في فايل لوحده وضيف عليه الايفنت بتاع ال get user بمعرفتك و استدعيهم في ال splash
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(create: (context) => MainCubit.get()),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              AuthInitial(),
            ),
          ),
          BlocProvider<ChatBloc>(
            create: (BuildContext context) => ChatBloc(
              ChatInitial(),
            )..add(GetConnectionEvent()),
          ),
          //   BlocProvider<GamesBloc>(create: (BuildContext context) => GamesBloc.get()),
          BlocProvider<PlaceCubit>(
              create: (BuildContext context) => PlaceCubit.get()),
          BlocProvider<PaymentCubit>(
              create: (BuildContext context) => PaymentCubit.get()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          AppRouter appRouter = AppRouter();
          return BlocBuilder<MainCubit, MainState>(
            bloc: MainCubit.get(),
            builder: (context, state) {
              return MaterialApp(
                title: LocalizationManager.getAppTitle(),
                initialRoute: Routes.splash,
                onGenerateRoute: appRouter.onGenerateRoute,
                locale: LocalizationManager.getCurrentLocale(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: getAppTheme(),
              );
            },
          );
        }));
  }
}

// Todo: edit app UI  //
// Todo: dashboard permissions //
// add admin, delete admin, edit admin , add user, delete reservation,

// TODO: requirements files
// TODO: contact between admin and owner
// TODO: add user gender **
// TODO: refund policy
// TODO: add feedback between players
// TODO: deposit
// TODO: Leave game
// TODO: dashboard reports
// TODO: admin permissions
