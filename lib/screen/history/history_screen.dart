import 'package:flutter/cupertino.dart';
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
  List<String> header = [];
  List<List<String>> listOfLists = [];

  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(const FetchHistoryEvent());
    header.add('dateTime');
    header.add('description');
    header.add('status');
    header.add('timeHistory');
    header.add('title');
    header.add('userId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          context.localization.history,
          style: const TextStyle(
              color: TaskColors.backgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if(state is HistoryInitial ){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Column(
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
                              height: 140,
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
                                  height: 140,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: TaskColors.backgroundColor,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                          bottomLeft: Radius.circular(3),
                                          topLeft: Radius.circular(3)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(4, 4),
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
                                          style: TextStyle(
                                              color: TaskColors.lightBlackColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          state.taskList?[index].description ??
                                              '',
                                          style: TextStyle(
                                              color: TaskColors.hintColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Divider(
                                          color: TaskColors.hintColor,
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
                                                  child: Text(
                                                    DateFormat("d MMM yyyy")
                                                        .format(state
                                                        .taskList?[
                                                    index]
                                                        .dateTime ??
                                                        DateTime.now()),
                                                    style: FontStyleText
                                                        .text12W400LightBlack,
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
                                                  child: Text(
                                                    DateFormat("hh:mm").format(
                                                        state.taskList?[index]
                                                            .dateTime ??
                                                            DateTime.now()),
                                                    style: FontStyleText
                                                        .text12W400LightBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(child: SizedBox()),
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
              Padding(
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
                    style: FontStyleText.text16W500White,
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
