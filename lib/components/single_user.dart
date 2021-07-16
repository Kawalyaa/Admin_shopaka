import 'package:flutter/material.dart';

import '../constants.dart';

class SingleUser extends StatelessWidget {
  final String photo;
  final String userName;
  final String email;
  final String phone;
  final Function deleteCallback;

  SingleUser(
      {this.photo, this.userName, this.email, this.phone, this.deleteCallback});

  RichText _richText(String firstText, String secondText) {
    return RichText(
      text: TextSpan(
          text: firstText,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: secondText,
              style:
                  TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 6.0),
      child: Card(
              child: ListTile(
          leading: photo.isEmpty
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      userName[0],
                      style: TextStyle(color: kColorRed,fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              : ClipOval(
                  child: Image.network(
                    photo,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _richText('Name: ', '$userName'),
              _richText('Email: ', '$email'),
              _richText('Phone: ', '$phone'),
            ],
          ),
          trailing: IconButton(
              onPressed: deleteCallback,
              icon: Icon(
                Icons.delete,
                color: kColorRed,
              )),
        ),
      ),
    );
  }
}