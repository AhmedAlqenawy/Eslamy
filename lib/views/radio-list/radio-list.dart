import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/models/radio-list.dart';
import 'package:player/services/RadioPlayer.dart';
import 'package:player/views/radio-list/radio-list-view-model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioListPage extends StatelessWidget {
  @override
  bool first=true;
  RadioPlayerController radioController=Get.find<RadioPlayerController>();
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RadioProvider(),
      child: Scaffold(
        backgroundColor: primColor,
        appBar: myAppBar('قائمة قنوات الراديو'),
        body: SafeArea(
            child: Selector<RadioProvider, List<RadioModel>>(
                selector: (context, getRadio) {

            getRadio.fetchRadioList();

          return getRadio.getRadioList;
        },
          builder: (ctx, radioList, widget) {
          return radioList.length == 0
              ? spinKit(context)
              : ListView.builder(
                  itemCount: radioList.length,
                  itemBuilder: (context, index) => Container(
                        height: 0.12.sh,
                        margin: EdgeInsets.all(5.sp),
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [myBoxShadow]),
                        child:
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: <Widget>[
//                            Container(
//                              width: 0.1.sh,
//                              margin: EdgeInsets.symmetric(horizontal: 7.sp),
//                             // alignment: Alignment.center,
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(50.r),
//                                  image: DecorationImage(
//                                      image: NetworkImage(index == 3
//                                          ? 'https://i.gifer.com/Pf0j.gif'
//                                          : 'https://png.pngtree.com/png-vector/20190901/ourlarge/pngtree-radio-icon-design-vector-png-image_1712465.jpg'),
//                                      fit: BoxFit.fill),
//                                  boxShadow: [myBoxShadow]),
//                              //child: Icon(Icons.book,color: Color(0xFFFF4F7D),),
//                            ),
                           radioRunContainer(radioList[index],  0.1.sh,radioController),
                           Container(
                             width: 0.6.sw,
                             child: autoText(radioList[index].name, 2, 20.ssp,
                                 FontWeight.w600, Colors.black),
                           ),
                         ],
                        )
                      ));
        })),
      ),
    );
  }
}
