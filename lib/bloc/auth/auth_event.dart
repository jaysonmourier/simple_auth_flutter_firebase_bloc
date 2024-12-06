// Base class for all auth events
abstract class AuthEvent {}

// Event for registering a new user
class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister(this.email, this.password);
}

// Event for logging in a user
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogIn(this.email, this.password);
}

// Event for logging out a user
class AuthEventLogOut extends AuthEvent {}
