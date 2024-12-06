import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  void _onRegisterButtonPressed() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      context
          .read<AuthBloc>()
          .add(AuthEventRegister(_email.text, _password.text));
    }
  }

  void _onLoginButtonPressed() {
    context.go('/login');
  }

  Widget _buildRegisterPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Register'),
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
              onPressed: _onRegisterButtonPressed,
              child: const Text('Register')),
          const SizedBox(height: 32.0),
          // go to register page
          TextButton(
              onPressed: _onLoginButtonPressed,
              child: const Text('Already have an account?')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthStateError) {
            return Center(child: Text(state.message));
          }

          return _buildRegisterPage();
        },
      ),
    );
  }
}
