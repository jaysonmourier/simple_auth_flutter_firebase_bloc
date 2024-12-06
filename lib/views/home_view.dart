import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onLogOut(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventLogOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome !'),
            Text(FirebaseAuth.instance.currentUser?.email ?? ''),
            const SizedBox(height: 32.0),
            ElevatedButton(
                onPressed: () => _onLogOut(context),
                child: const Text('Log Out')),
          ],
        ),
      ),
    );
  }
}
