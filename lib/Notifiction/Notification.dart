import 'package:Nimaz_App_Demo/Notifiction/notificationPlugin.dart';
import 'package:Nimaz_App_Demo/Notifiction/notificationScreens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification extends StatefulWidget {
  final String title, body;

  notification({Key key, @required this.title, @required this.body})
      : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  void initState() {
    super.initState();
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_icon'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                child: Text('Send notification'),
                onPressed: () async {
                  await notificationPlugin.showNotification(
                      widget.title, widget.body);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => notificationScreen(msg: payload),
        ));
  }
}
