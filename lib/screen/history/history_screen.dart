import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_tracking_demo/constants/function.dart';
import 'package:time_tracking_demo/localization/localization.dart';
import 'package:time_tracking_demo/screen/history/bloc/history_bloc.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> header = [
    "dateTime",
    "description",
    "status",
    "timeHistory",
    "title",
    "userId"
  ];

  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(const FetchHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        // foregroundColor: Theme.of(context).backgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          context.localization.history,
          style:  TextStyle(
              color: TaskColors.backgroundColor, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return  state.taskList?.isEmpty ?? true?
          const Center(child: Text('No History found'),) :
          Column(
            children: [
              const SizedBox(
                height: 12,
              ),
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
                              height: 150,
                              width: 8,
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
                                  height: 150,
                                  width: double.infinity,
                                  decoration:  BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(3),
                                          topLeft: Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).shadowColor,
                                            offset: Offset(0, 4),
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
                                          state.taskList?[index].title ?? '',
                                          style: Theme.of(context).textTheme.headline2,
                                        ),
                                        subtitle: Text(
                                          state.taskList?[index].description ??
                                              '',
                                          style:  Theme.of(context).textTheme.headline5,
                                        ),
                                      ),
                                      Divider(
                                          color: Theme.of(context).hintColor,
                                          endIndent: 8,
                                          indent: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_calander.png",
                                                  scale: 1.8,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text( state
                                                      .taskList![
                                                  index]
                                                      .endTime!.isEmpty ? "No Date Selected" :
                                                    DateFormat("d MMM yyyy")
                                                        .format(DateTime.parse(state
                                                        .taskList?[
                                                    index]
                                                        .endTime!.last ?? "") ??
                                                        DateTime.now()),
                                                    style: Theme.of(context).textTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/ic_clock.png",
                                                  scale: 1.8,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Text(state.taskList![index]
                                                      .timeHistory!.isEmpty ? "No Time " :
                                                    state.taskList?[index]
                                                        .timeHistory?.last.split(".").first ?? "",
                                                    style: Theme.of(context).textTheme.headline6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Container(
                                              height: 35,
                                              width: 80,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                context.localization.completed,
                                                style: FontStyleText
                                                    .text14W500Green,
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
                  exportCSV.myCSV(header, state.listOfCsvList!);
                },
                child: Padding(
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
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
