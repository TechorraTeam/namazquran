import 'package:flutter/material.dart';

class notificationScreen extends StatefulWidget {
  final String msg;
  notificationScreen({Key key, @required this.msg}) : super(key: key);
  @override
  _notificationScreenState createState() => _notificationScreenState();
}

class _notificationScreenState extends State<notificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(child: Text(widget.msg)),
    );
  }
}
