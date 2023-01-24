import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_demo/localization/localization.dart';

import '../../localization/bloc/localization_bloc.dart';
import '../../localization/i10n.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: PopupMenuButton(
        offset: const Offset(110, 0),
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              context.localization.selectLanguage,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Icon(Icons.arrow_drop_down_outlined,color: Theme.of(context).textTheme.subtitle2?.color,)
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
    );
  }
}
