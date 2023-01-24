import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_tracking_demo/constants/assets_constant.dart';
import 'package:time_tracking_demo/constants/function_constant.dart';
import 'package:time_tracking_demo/constants/size_constant.dart';
import 'package:time_tracking_demo/constants/string_constant.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/history/bloc/history_bloc.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> _header = [
    "dateTime",
    "description",
    "status",
    "timeHistory",
    "title",
    "userId"
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(const FetchHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return state.taskList?.isEmpty ?? true
              ? const Center(child: Text(StringConstant.noHistoryFoundString),)
              : Column(
                  children: [
                    SizeConstant.height12,
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.taskList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 12),
                              child: Row(
                                children: [
                                  Container(
                                    height: SizeConstant.size150,
                                    width: SizeConstant.size8,
                                    decoration: BoxDecoration(
                                      color: getColor(
                                          state.taskList?[index].status ?? ''),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          bottomLeft: Radius.circular(6)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: SizeConstant.size150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: const BorderRadius
                                                    .only(
                                                bottomRight: Radius.circular(6),
                                                topRight: Radius.circular(6),
                                                bottomLeft: Radius.circular(3),
                                                topLeft: Radius.circular(3)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context)
                                                      .shadowColor,
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 10)
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                state.taskList?[index].title ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Text(
                                                state.taskList?[index]
                                                        .description ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Divider(
                                                color:
                                                    Theme.of(context).hintColor,
                                                endIndent: 8,
                                                indent: 8),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(SizeConstant.size8),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        Assets.lib.images.calanderIcon.path,
                                                        scale: 1.8,
                                                      ),
                                                      Padding(padding: const EdgeInsets.all(SizeConstant.size8),
                                                        child: Text(
                                                          state.taskList?[index].endTime?.isEmpty ?? true
                                                              ? StringConstant.noDataSelectedString
                                                              : DateFormat("d MMM yyyy").format(DateTime.parse(state.taskList?[index].endTime?.last ?? "")),
                                                          style: Theme.of(context).textTheme.headline6,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        Assets.lib.images.clockIcon.path,
                                                        scale: 1.8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(SizeConstant.size8),
                                                        child: Text(
                                                          state.taskList?[index].timeHistory?.isEmpty ?? false
                                                              ? StringConstant.noTimeString
                                                              : state.taskList?[index].timeHistory?.last
                                                                      .split(".").first ?? "",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Expanded(child: SizedBox()),
                                                  Container(
                                                    height: SizeConstant.size35,
                                                    width: SizeConstant.size80,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: Text(
                                                      context.localization.completed,
                                                      style: FontStyleText.text14W500Green,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        exportCSV.myCSV(_header, state.listOfCsvList!);
                      },
                      child: _download(),
                    )
                  ],
                );
        },
      ),
    );
  }

  ///AppBar
  _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: TaskColors.backgroundColor,
      title: Text(
        context.localization.history,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  ///Download
  _download() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        alignment: Alignment.center,
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          context.localization.download,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
