import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/localization/localization.dart';

import '../localization/bloc/localization_bloc.dart';
import '../localization/i10n.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PopupMenuButton(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Select Language',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(context.localization.english,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context
                    .read<LocalizationsBloc>()
                    .add(ChangeLocale(L10n.enUS.getLocale())),
              ),
              PopupMenuItem(
                child: Text(context.localization.german,
                    style: Theme.of(context).textTheme.subtitle2),
                onTap: () => context
                    .read<LocalizationsBloc>()
                    .add(ChangeLocale(L10n.de.getLocale())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}