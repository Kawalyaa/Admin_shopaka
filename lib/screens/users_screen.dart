import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/constants.dart';
import 'package:shopla_ecommerce_app/db/user_service.dart';
import 'package:shopla_ecommerce_app/model/user_model.dart';

class UsersList extends StatelessWidget {
  static const String id = 'userList';
  @override
  Widget build(BuildContext context) {
    List<UserModel> _usersList = Provider.of<List<UserModel>>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Users',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ListView.builder(
        itemCount: _usersList.length,
        itemBuilder: (contex, index) => SingleUser(
          userName: _usersList[index].name,
          email: _usersList[index].email,
          photo: _usersList[index].photo,
          phone: _usersList[index].phone,
          deleteCallback: () {
            UserServices().deleteUser(_usersList[index].id);
          },
        ),
      ),
    );
  }
}

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
    );
  }
}
