import 'package:flutter/material.dart';
import 'package:flutter_zoom_sdk/zoom_options.dart';
import 'package:flutter_zoom_sdk/zoom_view.dart';

class ZoomMeeting extends StatefulWidget {
  @override
  _ZoomMeetingState createState() => _ZoomMeetingState();
}

class _ZoomMeetingState extends State<ZoomMeeting> {
  late ZoomOptions zoomOptions;
  late ZoomMeetingOptions meetingOptions;

  @override
  void initState() {
    super.initState();
    zoomOptions = ZoomOptions(
      domain: "zoom.us",
      appKey: "YOUR_ZOOM_SDK_KEY", // Replace with your SDK Key
      appSecret: "YOUR_ZOOM_SDK_SECRET", // Replace with your SDK Secret
    );
    meetingOptions = ZoomMeetingOptions(
      userId: 'example@domain.com', // Replace with your user ID
      displayName: 'Your Name', // Replace with your name
      meetingId: '123456789', // Replace with your meeting ID
      meetingPassword: 'password', // Replace with your meeting password
      disableDialIn: "true",
      disableDrive: "true",
      disableInvite: "true",
      disableShare: "true",
      noAudio: "false",
      noDisconnectAudio: "false",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                joinMeeting();
              },
              child: Text('Join Meeting'),
            ),
          ],
        ),
      ),
    );
  }

  void joinMeeting() {
    ZoomView().initZoom(zoomOptions).then((results) {
      if (results[0] == 0) {
        ZoomView().joinMeeting(meetingOptions).then((joinMeetingResult) {
          if (joinMeetingResult) {
            // Meeting joined successfully
          } else {
            // Handle join meeting failure
          }
        }).catchError((error) {
          // Handle join meeting error
          print('Error joining meeting: $error');
        });
      } else {
        // Handle Zoom SDK initialization error
        print('Error initializing Zoom SDK: ${results[1]}');
      }
    }).catchError((error) {
      // Handle Zoom SDK initialization error
      print('Error initializing Zoom SDK: $error');
    });
  }
}
