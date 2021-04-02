import 'package:flutter/material.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:provider/provider.dart';
 import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/models/reciter.dart';
import 'package:player/views/list-of-reciters/list-of-reciters-view-model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/views/list-of-seur/list-of-sur.dart';

// ignore: must_be_immutable
class RecitersPage extends StatelessWidget {
  RecitersPage(this.filterCondition);
  String filterCondition;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RecitersProvider(),
      child: Scaffold(
        backgroundColor: primColor,
        appBar: myAppBar('قائمة المقرئيين'),
        body: SafeArea(
            child: Selector<RecitersProvider, List<Reciter>>(
                selector: (context, getReciter) {
          getReciter.fetchRecitersList(filterCondition);
          return getReciter.getRecitersList;
        }, builder: (ctx, recitersList, widget) {
          return recitersList.length == 0
              ? spinKit(context)
              : ListView.builder(
                  itemCount: recitersList.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfSurPage(recitersList[index].name,recitersList[index].server)));
                      },
                    child: Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            Container(
                              height: 0.12.sh,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 7.sp, vertical: 0.03.sh),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [myBoxShadow]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 0.22.sw, left: 0.01.sw),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        autoText(
                                            recitersList[index].name,
                                            2,
                                            21.ssp,
                                            FontWeight.w700,
                                            Colors.black),
                                        autoText(recitersList[index].rewaya, 2,
                                            18.ssp, FontWeight.w500, Colors.grey),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ), Container(
                              width: 0.2.sw,
                              height: 0.15.sh,
                              margin: EdgeInsets.symmetric(horizontal: 7.sp),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://honnaimg.elwatannews.com/image_archive/840x601/8057321351517401834.jpg'),
                                      fit: BoxFit.fill),
                                  boxShadow: [myBoxShadow]),
                              //child: Icon(Icons.book,color: Color(0xFFFF4F7D),),
                            ),
                          ],
                        ),
                  ));
        })),
      ),
    );
  }
}
