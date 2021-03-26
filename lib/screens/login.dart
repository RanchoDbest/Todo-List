import 'package:flutter/material.dart';
import 'package:todo_list/models/user.dart';
import 'package:todo_list/utils/login_presenter.dart';
import 'package:todo_list/screens/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
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


  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new   ButtonTheme(
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
        child: const Text('SIGN IN',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
  );


    var loginForm =
    new Container(
      margin: new EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
      child:new Column(
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
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (val) => _email = val,
                  validator: validateEmail,
                  decoration: new InputDecoration(labelText: "Email"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  keyboardType:TextInputType.text,
                  textInputAction: TextInputAction.done,
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
            child: loginBtn
        ),
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text ("Don't have Account?",style: TextStyle(fontSize: 20, // light
            fontStyle: FontStyle.normal,),),
        ),

        new ButtonTheme(
          buttonColor: const Color(0xFFD81B60),
          minWidth: 350,
          height: 50.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: RaisedButton(
            padding: const EdgeInsets.all(10.0),
            onPressed: () => {Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),)},
            child: const Text('SIGN UP',
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
          ),
        ),

      ],
    ),
    );

    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Login"),
      // ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    print("invalid credential");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    setState(() {
      _isLoading = false;
    });

    if(user.flaglogged == "logged"){
      print("Logged");
      Navigator.of(context).pushReplacementNamed("/todo_list");
    }else{
      _showSnackBar("User not registered");
      print("Not Logged");
    }
  }
}
