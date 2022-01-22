import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/login/cubit/states.dart';
import 'package:messenger/styles/icon_broken.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix = IconBroken.Show;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Show : IconBroken.Hide;
    emit(LoginChangePasswordVisibilityState());
  }
}
