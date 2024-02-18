import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:brighter_nepal/models/chat_page_model.dart';
import 'package:brighter_nepal/values/styles.dart';
import 'package:brighter_nepal/values/user_logged_data.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:brighter_nepal/widgets/loading_animation.dart';
import 'package:brighter_nepal/widgets/services/chat_view_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat_view_page extends StatefulWidget {
  final int id;
  final String title;
  const Chat_view_page({super.key, required this.id, required this.title});

  @override
  State<Chat_view_page> createState() => _Chat_view_pageState();
}

class _Chat_view_pageState extends State<Chat_view_page> {
  @override
  void initState() {
    super.initState();
    loadSliderData();
  }

  String selected = "";
  Future<void> loadUserData() async {
    setState(() {
      selected = MySharedPreferences.getString(MyValues.SELECTION);
    });
  }

  bool is_loading = true;

  loadSliderData() async {
    ChatsModal.chatList.clear();
    var url = Uri.https(MyValues.server_url, MyValues.home_url);
    try {
      var response = await http.post(url, body: {
        'id': MySharedPreferences.getString(MyValues.USER_ID),
        'todo': "chat_page",
        'course_id': "${widget.id}",
        "course": MySharedPreferences.getString(MyValues.SELECTION).toString(),
      });

      if (response.statusCode == 200) {
        ChatsModal.chatList.clear();
        print('Response status: ${response.statusCode}');
        var dataHome = response.body.toString();
        var decodeHome = jsonDecode(dataHome);

        // Correct the key to access the array
        var messageList = decodeHome["messages"];

        // Update the structure of your Chats class to match the data
        List<Chats> chatsList =
            List<Chats>.from(messageList.map((e) => Chats.fromJson(e)));

        setState(() {
          ChatsModal.chatList.addAll(
              chatsList); // Use addAll to add elements to the existing list
          is_loading = false;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        is_loading = false;
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(0, 204, 107, 107),
          content: AwesomeSnackbarContent(
            title: 'We Could not Load Data ',
            message:
                'Sorry We could not load data from Server. Please Get Connected to Internet or Our Server Error may be occurred',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyValues.primary_color,
          title: Text(
            'BRIGHTER NEPAL - ${widget.title} ',
            style: TextStyle(color: Colors.white),
          ),
          leading: Image.asset("images/logo.jpg"),
        ),
        body: (is_loading == false)
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: (ChatsModal.chatList.length > 0)
                          ? ChatsModal.chatList.length
                          : 1,
                      reverse: true, // To display messages from bottom to top
                      itemBuilder: (context, index) {
                        return (ChatsModal.chatList.length > 0)
                            ? ChatViewCardWidget(
                                message: ChatsModal.chatList[index])
                            : Text(
                                "No Messages Found",
                                style: MyStyles.card_blue_text,
                              );
                      },
                    ),
                  ),
                ],
              )
            : SkeletonLoading());
  }
}
