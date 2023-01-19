import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/theme/bloc/theme_bloc.dart';
import 'package:time_tracking_demo/theme/theme.dart';

import '../constants/notification_helper.dart';
import '../theme/widget_theme/colors_and_text_style.dart';
import 'language_selection_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DayNightSwitcherIcon(
                      moonColor: mainBackGroundColor,
                      isDarkModeEnabled: state.status ?? false,
                      onStateChanged: (val) {
                        context.read<ThemeBloc>().add(ThemeChanged(
                            theme: val
                                ? TaskTheme.darkTheme
                                : TaskTheme.lightTheme,
                            status: val));
                      },
                    )),
              ],
            ),
            LanguageSelection(),
            SizedBox(
              height: 90,
            ),
            Text(context.localization.about),
            SizedBox(
              height: 90,
            ),
            ElevatedButton(
              onPressed: () async {
                _auth.signInAnonymously().then((value) {
                  print(value.user);
                });
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                NotificationService().showNotification(UniqueKey().hashCode, "Test", "this is Test");
              },
              child: const Text("gotoHell"),
            )
          ],
        ),
      ),
    );
  }
}
