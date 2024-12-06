import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthEventRegister>(_onAuthEventRegister);
    on<AuthEventLogIn>(_onAuthEventLogIn);
    on<AuthEventLogOut>(_onAuthEventLogOut);
  }

  Future<void> _onAuthEventRegister(
      AuthEventRegister event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }

  Future<void> _onAuthEventLogIn(
      AuthEventLogIn event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }

  Future<void> _onAuthEventLogOut(
      AuthEventLogOut event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      await FirebaseAuth.instance.signOut();
      emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }
}
