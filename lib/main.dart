import 'package:flutter/material.dart';
import 'package:todo_list/screens/create_event.dart';
import 'package:todo_list/screens/register.dart';
import 'package:todo_list/screens/login.dart';
import 'package:todo_list/screens/todo_list.dart';

void main() => runApp(MyApp());

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/todo_list': (BuildContext context) => new TodoList(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Todo App',
      theme: new ThemeData(primarySwatch: Colors.pink),
      routes: routes,
    );
  }
}
