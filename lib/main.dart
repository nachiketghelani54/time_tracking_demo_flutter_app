import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:time_tracking_demo/constants/notification_helper.dart';
import 'package:time_tracking_demo/constants/firebase_constant.dart';
import 'package:time_tracking_demo/constants/shared_preference.dart';
import 'package:time_tracking_demo/localization/i10n.dart';
import 'package:time_tracking_demo/screen/history/bloc/history_bloc.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bottom_nav_bar.dart';
import 'package:time_tracking_demo/screen/home/tabs/bloc/tab_bloc.dart';
import 'package:time_tracking_demo/theme/bloc/theme_bloc.dart';

import 'localization/bloc/localization_bloc.dart';
import 'localization/localization_delegate.dart';
import 'localization/localization_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LocalizationsBloc(localizationHelper: LocalizationHelper())
                ..add(const FetchLocaleFromSharedPref()),
        ),
        BlocProvider(
          create: (context) =>
              ThemeBloc(localizationHelper: LocalizationHelper())
                ..add(const FetchThemeFromSharedPref()),
        ),
        BlocProvider(
          create: (context) =>
              HistoryBloc(firebaseConstant: FirebaseConstant()),
        ),
        BlocProvider(
          create: (context) => BottomNavBloc()..add(const ChangeTab(0)),
        ),
        BlocProvider(create: (context) => TabBloc()..add(FetchTabEvent(0))),
      ],
      child: BlocBuilder<LocalizationsBloc, LocalizationsState>(
        builder: (context, localizationsState) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return _buildWithTheme(context, themeState, localizationsState);
            },
          );
        },
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState themeState,
      LocalizationsState localizationsState) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeState.appTheme,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        ShadeAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: localizationsState.locale,
      supportedLocales: L10n.all,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseConstant.analytics),
      ],
      home: BottomNavBarScreen(0),
    );
  }
}
