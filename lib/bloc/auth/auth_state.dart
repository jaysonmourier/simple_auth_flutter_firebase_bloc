// Base class for all auth states
abstract class AuthState {}

// State for initial state
class AuthStateInitial extends AuthState {}

// State for authenticated state
class AuthenticatedState extends AuthState {}

// State for unauthenticated state
class UnauthenticatedState extends AuthState {}

// State for error state
class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}

// State for loading
class AuthStateLoading extends AuthState {}
