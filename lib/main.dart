import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'РПМ #1 API JSON PLACEHOLDER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'РПМ #1 API JSON PLACEHOLDER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _todos = [];

  Future<void> _getTodos() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _todos = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _todos.isEmpty
            ? Text('No todos')
            : ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_todos[index]['title']),
              subtitle: Text(_todos[index]['completed'].toString()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodos,
        tooltip: 'Get Todos',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
