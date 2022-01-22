abstract class LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String? uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}
