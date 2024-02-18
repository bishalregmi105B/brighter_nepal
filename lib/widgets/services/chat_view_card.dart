import 'package:brighter_nepal/models/chat_page_model.dart';
import 'package:brighter_nepal/pages/services/service_handler.dart';
import 'package:brighter_nepal/values/values.dart';
import 'package:flutter/material.dart';

class ChatViewCard {
  final String text;

  ChatViewCard({required this.text});
}

class ChatViewCardWidget extends StatelessWidget {
  final Chats message;

  const ChatViewCardWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ActionHandler.handleAction(context, message.todo, message.name,
            url: message.url,
            activityName: message.act_name,
            extra_description: message.description);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: MyValues.primary_color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (message.imageUrl != "")
                ? Container(
                    child: Image.network(
                      message.imageUrl,
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            Text(
              message.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
