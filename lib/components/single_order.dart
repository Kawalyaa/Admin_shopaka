import 'package:flutter/material.dart';

import '../constants.dart';
class SingleOrder extends StatelessWidget {
  final String firstInfo;
  final String secondInfo;
   final String firstInfo2;
  final String secondInfo2;
  SingleOrder({this.firstInfo,this.secondInfo,this.firstInfo2,this.secondInfo2});

 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Card(
        color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 4, right: 4.0),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _orderRichText(firstInfo, secondInfo),
                  SizedBox(height:8),
                  _orderRichText(firstInfo2, secondInfo2)
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(primary:kColorRed),
                  onPressed: () {}, child: Text('Details')),
            ),
          ),
    );
  }



   _orderRichText(String firstInfo, String secondInfo) {
    return Padding(
      padding: EdgeInsets.only(top:2),
          child: RichText(
        text: TextSpan(
            text: '$firstInfo: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16),
            children: [
              TextSpan(
                text: secondInfo,
                style:
                    TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ]),
      ),
    );
  }
}
