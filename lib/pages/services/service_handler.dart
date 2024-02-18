import 'package:brighter_nepal/call_service.dart';
import 'package:brighter_nepal/pages/view_video.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/utils/pdf_viewer.dart';
import 'package:brighter_nepal/widgets/web_view.dart';
import 'package:flutter/material.dart';

class ActionHandler {
  static void handleAction(
    BuildContext context,
    String action,
    String title, {
    String id = "1",
    String activityName = '',
    String url = '',
    String extra_description = '',
  }) {
    switch (action) {
      case 'open_activity':
        if (shouldOpenActivity(activityName)) {
          openActivity(
              context, activityName, title, url, extra_description, id);
        } else {
          print('Condition not met to open the activity.');
        }
        break;
      case 'open_meeting':
        if (url.isNotEmpty) {
          MeetingUtils.joinMeeting(
            roomName: url,
            serverUrl: 'https://meet.jit.si',
            subject: extra_description,
            userDisplayName:
                MySharedPreferences.getString(MyValues.NAME).toString(),
            userEmail: MySharedPreferences.getString(MyValues.EMAIL).toString(),
          );
        }

      case 'webview':
        if (url.isNotEmpty) {
          print("object");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewHandler(
                initialUrl: url,
                title: title,
              ),
            ),
          );
        } else {
          print('Missing URL for open_webview action.');
        }
        break;
      // Add more cases for other actions if needed
      default:
        print('Unsupported action: $action');
    }
  }

  static bool shouldOpenActivity(String activityName) {
    // Add your condition for each activity here
    if (activityName == 'pdf_view') {
      // Condition for opening YourActivity1
      return true;
    } else if (activityName == 'video_view') {
      // Condition for opening YourActivity2
      return true;
    } else if (activityName == 'video_view') {
      // Condition for opening YourActivity2
      return true;
    }
    return false;
  }

  static void openActivity(BuildContext context, String activityName,
      String title, String url, String description, String id) {
    switch (activityName) {
      case 'pdf_view':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfViewerScreen(
                      id: id,
                      pdfUrl: url,
                      description: "",
                      title: title,
                    )));
        break;

      case 'video_view':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewVideo(
                      currentVideoId: url,
                      title: title,
                      description: description,
                    )));
        break;
      case 'about':
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => YourActivity2()));
        break;
      default:
        print('Unsupported activity: $activityName');
    }
  }
}
