import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_auth_flutter_firebase_bloc/views/home_view.dart';
import 'package:simple_auth_flutter_firebase_bloc/views/register_view.dart';
import 'package:simple_auth_flutter_firebase_bloc/views/login_view.dart';

class AppRouter {
  // firebase auth listener
  final ValueNotifier<User?> _user =
      ValueNotifier(FirebaseAuth.instance.currentUser);

  // listen to auth state changes
  AppRouter() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user.value = user;
    });
  }

  // router
  GoRouter get router => GoRouter(
          initialLocation: '/',
          refreshListenable: _user,
          redirect: (context, state) {
            print('Redirect called: ${state.uri}');
            // if user is not authenticated and not on login or register page, redirect to login
            if (_user.value == null &&
                state.uri.toString() != '/login' &&
                state.uri.toString() != '/register') {
              return '/login';
            } else if (_user.value != null &&
                (state.uri.toString() == '/login' ||
                    state.uri.toString() == '/register')) {
              return '/';
            }
            return null;
          },
          routes: [
            GoRoute(
                name: 'login',
                path: '/login',
                builder: (context, state) {
                  return const LoginView();
                }),
            GoRoute(
                name: 'register',
                path: '/register',
                builder: (context, state) {
                  return const RegisterView();
                }),
            GoRoute(
                name: 'home',
                path: '/',
                builder: (context, state) {
                  return const HomeView();
                }),
          ]);
}
