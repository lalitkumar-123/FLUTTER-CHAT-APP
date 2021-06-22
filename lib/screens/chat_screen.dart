import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './message.dart';
import './new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        actions: [
          DropdownButton(icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color),
          items: [
            DropdownMenuItem(child: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app),
                  SizedBox(width: 8,),
                  Text('Logout'),
                ],
              ),
            ),
              value: 'Logout',
            )
          ],
            onChanged: (item) {
              if(item == 'Logout')
              {
                  FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Message(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
