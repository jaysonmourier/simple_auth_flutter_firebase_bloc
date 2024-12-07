import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      context.read<AuthBloc>().add(AuthEventLogIn(_email.text, _password.text));
    }
  }

  void _onRegisterButtonPressed() {
    context.go('/register');
  }

  Widget _buildLoginPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login'),
          const SizedBox(height: 16.0),
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
              onPressed: _onLoginButtonPressed, child: const Text('Login')),
          const SizedBox(height: 32.0),
          // go to register page
          TextButton(
              onPressed: _onRegisterButtonPressed,
              child: const Text('Create an account')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildLoginPage();
          },
        ),
      ),
    );
  }
}
