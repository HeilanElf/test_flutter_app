import 'package:flutter/material.dart';
import 'todolist.dart';
import 'todolist.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedTabIndex = 0;

  List<Widget> _tabList = [
   AddTodoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tab Bar App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar App'),
        ),
        backgroundColor: Color.fromARGB(255, 168, 206, 244), //这里设置为灰色
        body: _tabList[_selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            
          ],
          currentIndex: _selectedTabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}