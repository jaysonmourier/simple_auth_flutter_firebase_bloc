import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_state.dart';
import 'package:simple_auth_flutter_firebase_bloc/utils/validator.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
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
    if (_formKey.currentState!.validate()) {
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register'),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!Validator.isValidEmail(value)) {
                  return 'Invalid email';
                }

                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _password,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                if (!Validator.isValidPassword(value)) {
                  return 'Invalid password';
                }

                return null;
              },
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return _buildRegisterPage();
          },
        ),
      ),
    );
  }
}
