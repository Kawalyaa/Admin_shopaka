import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopla_ecommerce_app/components/single_user.dart';
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
