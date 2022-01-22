import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/models/social_user_model/user_model.dart';
import 'package:messenger/modules/register/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/styles/icon_broken.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // late LoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
      );
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image:
          'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
      cover:
          'https://image.freepik.com/free-vector/happy-new-year-2022-background-with-bokeh_1361-3771.jpg',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = IconBroken.Show;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconBroken.Show : IconBroken.Hide;
    emit(RegisterChangePasswordVisibilityState());
  }
}
