import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/constants/text_style.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/bottom_nav/bloc/bottom_nav_bloc.dart';
import 'package:time_tracking_demo/screen/language/language_selection_screen.dart';
import 'package:time_tracking_demo/theme/bloc/theme_bloc.dart';
import 'package:time_tracking_demo/theme/theme.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, bottomState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///localization
                  _localization(context),
                  ///Theme
                  _theme(context),
                  _divider(context),
                  ///Language
                  _language(),
                  _divider(context),
                  ///Home
                  _home(context),
                  _divider(context),
                  ///History
                  _history(context),
                  _divider(context),
                ],
              );
            },
          );
        },
      ),
    );
  }

  ///Localization
  _localization(BuildContext context){
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          SizeConstant.height20,
          Padding(
            padding: const EdgeInsets.all(SizeConstant.size8),
            child: Row(
              children: [
                const FlutterLogo(
                  size: SizeConstant.size80,
                ),
                Text(
                  StringConstant.flutterString,
                  style: FontStyleText.text22W500White,
                )
              ],
            ),
          ),
          SizeConstant.height10
        ],
      ),
    );
  }
  ///Theme
  _theme(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(SizeConstant.size8),
      child: Row(
        children: [
          PopupMenuButton(
            offset: const Offset(110, 0),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.localization.theme,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(context.localization.light,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context.read<ThemeBloc>().add(
                    ThemeChanged(
                        theme: TaskTheme.lightTheme,
                        status: true)),
              ),
              PopupMenuItem(
                child: Text(context.localization.dark,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context.read<ThemeBloc>().add(
                    ThemeChanged(
                        theme: TaskTheme.darkTheme,
                        status: true)),
              ),
              PopupMenuItem(
                child: Text(context.localization.red,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context.read<ThemeBloc>().add(
                    ThemeChanged(
                        theme: TaskTheme.redTheme, status: true)),
              ),
              PopupMenuItem(
                child: Text(context.localization.green,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context.read<ThemeBloc>().add(
                    ThemeChanged(
                        theme: TaskTheme.greenTheme,
                        status: true)),
              ),
              PopupMenuItem(
                child: Text(context.localization.orange,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context.read<ThemeBloc>().add(
                    ThemeChanged(
                        theme: TaskTheme.orangeTheme,
                        status: true)),
              ),
            ],
          ),
        ],
      ),
    );
  }
  ///Language
  _language(){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeConstant.size8,
          vertical: SizeConstant.size8),
      child: Row(
        children: const [LanguageSelection()],
      ),
    );
  }

  ///Home Menu
  _home(BuildContext context){
    return GestureDetector(
      onTap: () {
        context
            .read<BottomNavBloc>()
            .add(const ChangeTab(SizeConstant.index0));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(SizeConstant.size8),
        child: Text(context.localization.home,
            style: Theme.of(context).textTheme.headline2),
      ),
    );
  }

  ///History Menu
  _history(BuildContext context){
    return GestureDetector(
      onTap: () {
        context
            .read<BottomNavBloc>()
            .add(const ChangeTab(SizeConstant.index1));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(SizeConstant.size8),
        child: Text(context.localization.history,
            style: Theme.of(context).textTheme.headline2),
      ),
    );
  }

  ///Divider
  _divider(BuildContext context) {
    return Divider(
      color: Theme.of(context).hintColor,
    );
  }
}
