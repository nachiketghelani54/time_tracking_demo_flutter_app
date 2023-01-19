import 'package:flutter/material.dart';
import 'package:time_tracking_demo/localization/localization.dart';

class PopUpHelper extends StatefulWidget {
  const PopUpHelper({Key? key}) : super(key: key);

  @override
  State<PopUpHelper> createState() => _PopUpHelperState();
}

class _PopUpHelperState extends State<PopUpHelper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: PopupMenuButton(
        constraints: const BoxConstraints(maxWidth: 130),
        offset: const Offset(110, 0),
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              children: [
                Image.asset("assets/images/edit.png"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  context.localization.edit,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/add.png",
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(context.localization.create,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            child: Row(
              children: [
                Image.asset("assets/images/move.png"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  context.localization.move,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
