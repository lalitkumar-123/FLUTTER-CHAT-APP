import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageText extends StatelessWidget {
  MessageText(this.message, this.isMe, this.username, this.url ,{this.key});

  final Key key;
  final String message;
  final String username;
  final String url;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 100,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(children: <Widget>[
            Text(username, style: TextStyle(color: Colors.pink)),
            Text(message, style: TextStyle(color: Colors.black)),
          ],
          ),
        ),
      ],
      ),
        Positioned(
            top: -10,
            left: isMe ? null : 120,
            right: isMe ? 120: null,
            child: CircleAvatar(backgroundImage: NetworkImage(url),)),
      ],
      clipBehavior: Clip.none,
    );
  }
}
