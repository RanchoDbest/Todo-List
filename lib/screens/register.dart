import 'package:flutter/material.dart';
import 'package:todo_list/data/user_database_helper.dart';
import 'package:todo_list/models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _username, _password;



  @override
  Widget build(BuildContext context) {
    _ctx = context;
     var loginBtn =
     new   ButtonTheme(
       padding: const EdgeInsets.all(20.0),
       buttonColor: const Color(0xFFD81B60),
       minWidth: 350,
       height: 50.0,
       shape: new RoundedRectangleBorder(
         borderRadius: new BorderRadius.circular(30.0),
       ),
       child: RaisedButton(
         padding: const EdgeInsets.all(10.0),
         onPressed: () => {
           _submit()
         },
         child: const Text('SUBMIT',
             style: TextStyle(color: Colors.white, fontSize: 20.0)),
       ),
     );



    var loginForm = new Container(
      margin: new EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
      child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,

          child: new Column(

            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSaved: (val) => _name = val,
                  validator: validateName,
                  decoration: new InputDecoration(labelText: "Name"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),

                child: new TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) => _username = val,
                  validator: validateEmail,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  onSaved: (val) => _password = val,
                  validator: validatePassword,
                  decoration: new InputDecoration(labelText: "Password"),
                    obscureText: true
                ),
              )
            ],
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: loginBtn,
        )
      ],
    ),
    );

    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Register"),
      // ),
      key: scaffoldKey,
      body: new Container(

        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'First name must be more than 3 charaters';
    else
      return null;
  }


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().length < 6)
      return 'Password must be 6 character length';
    else
      return null;
  }

  void _submit(){
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(_name, _username, _password, null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushReplacementNamed("/todo_list");
      });
    }
  }
}