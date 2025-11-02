abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });
}

class TogglePasswordRegister extends RegisterEvent{}

class ToggleConfirmPasswordRegister extends RegisterEvent{}

class NameChangedRegister extends RegisterEvent {
  final String name;
  NameChangedRegister(this.name);
}

class EmailChangedRegister extends RegisterEvent {
  final String email;
  EmailChangedRegister(this.email);
}

class PasswordChangedRegister extends RegisterEvent {
  final String password;
  PasswordChangedRegister(this.password);
}

class ConfirmPasswordChangedRegister extends RegisterEvent {
  final String password;
  final String confirmPassword;
  ConfirmPasswordChangedRegister(this.password,this.confirmPassword);
}
