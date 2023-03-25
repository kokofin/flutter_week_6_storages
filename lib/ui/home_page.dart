import 'package:flutter/material.dart';
import 'package:flutter_week_6_storages/models/user_model.dart';
import 'package:flutter_week_6_storages/models/shared_preferences_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<UserModel?>(
          future: SharedPreferencesHelper.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final UserModel user = snapshot.data!;
              return Text('Welcome, ${user.username}!');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SharedPreferencesHelper.removeUser();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/login');
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}
