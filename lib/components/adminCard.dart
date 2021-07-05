import 'package:flutter/material.dart';

class SingleCard extends StatelessWidget {
  final Color activeColor;
  final Icon icon;
  final String iconName;
  final String value;
  final Function onTap;

  const SingleCard({
    this.onTap,
    @required this.activeColor,
    @required this.icon,
    @required this.iconName,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  iconName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60.0, color: activeColor),
            )
          ],
        ),
      ),
    );
  }
}
