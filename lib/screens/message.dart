import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_text.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, futureSnapshot) {
            if(futureSnapshot.connectionState == ConnectionState.waiting)
            {
                return Center(child: CircularProgressIndicator());
            }
          return StreamBuilder(
          stream: Firestore.instance.collection('/chats/5q91uNOSc7uXu5wsXWd8/message').orderBy('createdAt', descending: true).snapshots() ,
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if(streamSnapshot.connectionState == ConnectionState.waiting)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: streamSnapshot.data.documents.length,
            itemBuilder: (context, index) => MessageText(streamSnapshot.data.documents[index]['text'],
              streamSnapshot.data.documents[index]['userId'] == futureSnapshot.data.uid,
              streamSnapshot.data.documents[index]['username'],
              streamSnapshot.data.documents[index]['image_url'],
              key: ValueKey(streamSnapshot.data.documents[index].documentID),
            ),
            );
          });
          });
    }
  }
