import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import './imagepicker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);
  final void Function (String email, String name, String password, File image, bool is_Login, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  String _email = "";
  String _name = "";
  String _password = "";
  File _imageuser;

  void _usersimage(File image)
  {
      _imageuser = image;
  }

  void _trySubmit() {
    final isvalid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_imageuser == null && !_isLogin)
    {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please upload image!"),));
      return;
    }

    if(isvalid)
    {
        _formKey.currentState.save();
        widget.submitFn(_email,_name,_password,_imageuser,_isLogin,context) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if(!_isLogin) ImagePicker(_usersimage),
                      TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if(value.isEmpty || !value.contains('@'))
                            {
                              return "Please enter correct email!";
                            }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        onSaved: (value) {
                            _email = value;
                        },
                      ),
                          if(!_isLogin)
                              TextFormField(
                                key: ValueKey('name'),
                                validator: (value) {
                                  if (value.length < 4) {
                                    return "Please enter atleast 4 character name!";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                ),
                                onSaved: (value) {
                                  _name = value;
                                },
                              ),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if(value.length < 6)
                            {
                              return "Please enter atleast 6 character password!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                          onSaved: (value) {
                            _password = value;
                          },
                      ),
                      SizedBox(height: 20,),
                      RaisedButton(child: Text(_isLogin?"Login":"Signup"), onPressed: _trySubmit,),
                      FlatButton(child: Text(_isLogin?"Create an Account":"Already have an account"), onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },),
                     ],
                  ),
                ),
              ),
          )
        ),
      )
    );
  }
}
