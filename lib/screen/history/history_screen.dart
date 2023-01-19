import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TaskColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text("History",style: TextStyle(color: TaskColors.backgroundColor,fontSize: 18,fontWeight: FontWeight.w500),),
        centerTitle: true,
        elevation: 0,

      ),
      body: Column(
        children: [
          SizedBox(height: 12,),
          Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
              child: Row(
                children: [
                  Container(
                    height: 140,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomLeft: Radius.circular(6)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: TaskColors.backgroundColor,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),topRight: Radius.circular(6),bottomLeft: Radius.circular(3),topLeft: Radius.circular(3)),
                            boxShadow: [
                              BoxShadow(color: Colors.grey,offset: Offset(4, 4),blurRadius: 10)
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            ListTile(
                              title: Text("SAL | Create Api definition for ",style: TextStyle(color: TaskColors.lightBlackColor,fontSize: 14,fontWeight: FontWeight.bold),),
                              subtitle: Text("Website UI Design for",style: TextStyle(color: TaskColors.hintColor,fontSize: 12,fontWeight: FontWeight.w500),),
                              trailing: Icon(Icons.more_vert_outlined),
                            ),
                            Divider(color: TaskColors.hintColor,endIndent: 8,indent: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/ic_calander.png",scale: 1.8,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("21/10/2023",style: FontStyleText.text12W400LightBlack,),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Image.asset("assets/images/ic_clock.png",scale: 1.8,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("21/10/2023",style: FontStyleText.text12W400LightBlack,),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 35,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    child: Text("Completed",style: FontStyleText.text14W500Green,),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
              child: Row(
                children: [
                  Container(
                    height: 140,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomLeft: Radius.circular(6)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: TaskColors.backgroundColor,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),topRight: Radius.circular(6),bottomLeft: Radius.circular(3),topLeft: Radius.circular(3)),
                            boxShadow: [
                              BoxShadow(color: Colors.grey,offset: Offset(4, 4),blurRadius: 10)
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            ListTile(
                              title: Text("SAL | Create Api definition for ",style: TextStyle(color: TaskColors.lightBlackColor,fontSize: 14,fontWeight: FontWeight.bold),),
                              subtitle: Text("Website UI Design for",style: TextStyle(color: TaskColors.hintColor,fontSize: 12,fontWeight: FontWeight.w500),),
                              trailing: Icon(Icons.more_vert_outlined),
                            ),
                            Divider(color: TaskColors.hintColor,endIndent: 8,indent: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/ic_calander.png",scale: 1.8,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("21/10/2023",style: FontStyleText.text12W400LightBlack,),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Image.asset("assets/images/ic_clock.png",scale: 1.8,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("21/10/2023",style: FontStyleText.text12W400LightBlack,),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 35,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: TaskColors.primaryColor,
                                    ),
                                    child: Text("Completed",style: FontStyleText.text14W500Green,),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ],
              )),
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
              child: Text("Download",style: FontStyleText.text16W500White,),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(CupertinoIcons.add),backgroundColor: TaskColors.primaryColor,elevation: 0,),
    );
  }
}
