import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TodoItem {
  String title;
  String content;
  bool isDone;

  TodoItem({required this.title, required this.content, required this.isDone});
}

class TodoList extends ChangeNotifier {
  List<TodoItem> _items = [];

  List<TodoItem> get items => _items;

  void addItem(TodoItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleItem(int index) {
    _items[index].isDone = !_items[index].isDone;
    notifyListeners();
  }
}
class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoList.items.length,
        itemBuilder: (context, index) {
          final item = todoList.items[index];
          return CheckboxListTile(
            title: Text(item.title),
            subtitle: Text(item.content),
            value: item.isDone,
            onChanged: (newValue) {
              todoList.toggleItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _content;

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final todoList = Provider.of<TodoList>(context, listen: false);
      todoList.addItem(TodoItem(title: _title, content: _content, isDone: false));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveTodo,
        child: Icon(Icons.save),
      ),
    );
  }
}