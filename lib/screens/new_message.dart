import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _message = "";
  final _controller = new TextEditingController();

  void _onSubmit () async {
      FocusScope.of(context).unfocus();
      final user = await FirebaseAuth.instance.currentUser();
      final userdata = await Firestore.instance.collection('users').document(user.uid).get();
      Firestore.instance.collection('/chats/5q91uNOSc7uXu5wsXWd8/message').add({
        'text': _message,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userdata['username'],
        'userimage': userdata['image_url'],
      });
      _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      child: Row(
        children: <Widget>[
            Expanded(child:
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send a message"),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),),
          IconButton(
            color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _message.trim ().isEmpty ? null : _onSubmit )
        ],
        ),
      );
  }
}
