import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_event.dart';
import 'package:simple_auth_flutter_firebase_bloc/bloc/auth/auth_state.dart';
import 'package:simple_auth_flutter_firebase_bloc/repository/user_repository.dart';
import 'package:simple_auth_flutter_firebase_bloc/utils/validator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthStateInitial()) {
    on<AuthEventRegister>(_onAuthEventRegister);
    on<AuthEventLogIn>(_onAuthEventLogIn);
    on<AuthEventLogOut>(_onAuthEventLogOut);
  }

  final UserRepository _userRepository;

  Future<void> _onAuthEventRegister(
      AuthEventRegister event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      if (!Validator.isValidEmail(event.email)) {
        emit(AuthStateError('Invalid email'));
        return;
      }
      if (!Validator.isValidPassword(event.password)) {
        emit(AuthStateError('Invalid password'));
        return;
      }
      await _userRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }

  Future<void> _onAuthEventLogIn(
      AuthEventLogIn event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      await _userRepository.signInWithEmailAndPassword(
          event.email, event.password);
      emit(AuthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }

  Future<void> _onAuthEventLogOut(
      AuthEventLogOut event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());
    try {
      await _userRepository.signOut();
      emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthStateError(e.toString()));
    }
  }
}
