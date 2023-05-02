import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// ignore: unused_import
import 'package:myapplication/home.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late List<User> _users;
  late File _usersFile;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final directory = await getApplicationDocumentsDirectory();
    _usersFile = File('${directory.path}/users.json');
    if (_usersFile.existsSync()) {
      final data = await _usersFile.readAsString();
      final users = List<Map<String, dynamic>>.from(jsonDecode(data)['users']);
      _users = users.map((user) => User.fromJson(user)).toList();
    } else {
      final response = await rootBundle.loadString('assets/users.json');
      final data = jsonDecode(response);
      final users = List<Map<String, dynamic>>.from(data['users']);
      _users = users.map((user) => User.fromJson(user)).toList();
      _saveUsers();
    }
  }

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final user = _users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => User(username: '', password: ''),
    );
    if (user.username.isNotEmpty) {
      _showDialog('Login successful!');
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeacherMatchPage()),
    );

    } else {
      _showDialog('Invalid username or password!');
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      _users.add(newUser);
      _saveUsers();
      _showDialog('Registration successful!');
    }
  }

  Future<void> _saveUsers() async {
    final users = {'users': _users.map((user) => user.toJson()).toList()};
    final jsonString = jsonEncode(users);
    await _usersFile.writeAsString(jsonString);
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Message'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radool!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}