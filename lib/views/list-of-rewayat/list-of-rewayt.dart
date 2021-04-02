import 'package:flutter/material.dart';
import 'package:player/components/constrains/constrain.dart';
import 'package:player/components/widgets/commen-widgets.dart';
import 'package:player/models/rewayat.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:player/views/list-of-reciters/list-of-reciters.dart';

class RewayatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      appBar: myAppBar('الروايـــأت'),
      body: SafeArea(
          child: ListView.builder(
              itemCount: rewayat.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RecitersPage(rewayat[index].name)));
                },
                child: Container(
                      height: 0.12.sh,
                      margin: EdgeInsets.all(5.sp),
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [myBoxShadow]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 0.6.sw,
                            child: autoText(rewayat[index].name, 2, 20.ssp,
                                FontWeight.w600, Colors.black),
                          ),
                        ],
                      ),
                    ),
              ))),
    );
  }
}
