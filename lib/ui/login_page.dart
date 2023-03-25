import 'package:flutter/material.dart';
import 'package:flutter_week_6_storages/models/shared_preferences_helper.dart';
import 'package:flutter_week_6_storages/models/user_model.dart';


class LoginPage extends StatefulWidget {
const LoginPage({Key? key}) : super(key: key);

@override
// ignore: library_private_types_in_public_api
_LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool _isLoading = false;
String? _errorMessage;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Login'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: <Widget>[
TextFormField(
controller: _usernameController,
decoration: const InputDecoration(labelText: 'Username'),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Username is required';
}
return null;
},
),
TextFormField(
controller: _passwordController,
decoration: const InputDecoration(labelText: 'Password'),
obscureText: true,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Password is required';
}
return null;
},
),
if (_errorMessage != null)
Padding(
padding: const EdgeInsets.all(8.0),
child: Text(
_errorMessage!,
style: const TextStyle(color: Colors.red),
),
),
ElevatedButton(
onPressed: _isLoading ? null : _handleLogin,
child: _isLoading
? const CircularProgressIndicator()
: const Text('Login'),
),
],
),
),
),
);
}

void _showLoading(bool isLoading) {
setState(() {
_isLoading = isLoading;
});
}

void _showErrorMessage(String errorMessage) {
setState(() {
_errorMessage = errorMessage;
});
}

Future<void> _handleLogin() async {
final String username = _usernameController.text;
final String password = _passwordController.text;
if (_formKey.currentState!.validate()) {
  _showLoading(true);

  // Simulate a network request
  await Future.delayed(const Duration(seconds: 2));

  // Check the username and password
  if (username == 'admin' && password == 'password') {
    final UserModel user = UserModel(username: username, password: password);
    await SharedPreferencesHelper.saveUser(user);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    _showErrorMessage('Invalid username or password');
  }

  _showLoading(false);
}
}
}