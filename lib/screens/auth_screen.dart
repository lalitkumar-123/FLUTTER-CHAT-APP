import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String name, String password, File image, bool is_Login, BuildContext ctx) async {
    AuthResult authresult;
    try {
      if(is_Login)
      {
        authresult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else {
        authresult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        final ref = FirebaseStorage.instance.ref().child('user_image').child(authresult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = ref.getDownloadURL();
        await Firestore.instance.collection('users').document(authresult.user.uid).setData({
          'username': name,
          'email': email,
          'image_url': url,
        });
      }
    } catch (err) {
      var message = "Credentials are incorrect!";
      if(err.message != null)
      {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message), backgroundColor: Theme.of(ctx).errorColor,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
