import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:time_tracking_demo/constants/shared_preference.dart';
import 'package:time_tracking_demo/localization/i10n.dart';
import 'package:time_tracking_demo/screen/bottom_nav_bar.dart';
import 'package:time_tracking_demo/screen/home.dart';
import 'package:time_tracking_demo/theme/bloc/theme_bloc.dart';

import 'localization/bloc/localization_bloc.dart';
import 'localization/localization_delegate.dart';
import 'localization/localization_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  await Firebase.initializeApp();
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        ShadeAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: localizationsState.locale,
      supportedLocales: L10n.all,
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('de', ''),
      // ],
      home:  BottomNavBarScreen(),
      // routes: {
      //   SiteSelectionPage.routeName: (context) => const SiteSelectionPage(),
      //   ExpenseTab.routeName: (context) => const ExpenseTab(),
      //   YearlyReportPage.routeName: (context) =>
      //   const YearlyReportPage(index: 'Monthly'),
      //   SignupPage.routeName: (context) => const SignupPage(),
      //   LoginPage.routeName: (context) => const LoginPage(),
      //   MyHomePage.routeName: (context) => const MyHomePage(),
      //   WebHomePage.routeName: (context) => const WebHomePage(),
      //   CreateSiteScreen.routeName: (context) => const CreateSiteScreen()
      // },
    );
  }
}
