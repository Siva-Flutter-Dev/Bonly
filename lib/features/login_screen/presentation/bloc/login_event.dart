abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class TogglePassword extends LoginEvent{}

class EmailChangedLogin extends LoginEvent {
  final String email;
  EmailChangedLogin(this.email);
}

class PasswordChangedLogin extends LoginEvent {
  final String password;
  PasswordChangedLogin(this.password);
}