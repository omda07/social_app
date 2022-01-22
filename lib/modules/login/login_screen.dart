import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/social_screen.dart';
import 'package:messenger/models/social_user_model/fade_animation.dart';
import 'package:messenger/modules/login/cubit/cubit.dart';
import 'package:messenger/modules/login/cubit/states.dart';
import 'package:messenger/modules/register/register_screen.dart';
import 'package:messenger/network/local/cache_helper.dart';
import 'package:messenger/styles/icon_broken.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final  formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(message: state.error, state: ToastStates.ERROR);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              color: Colors.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation('LOGIN'),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'login now to comumnicate with friends',
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),
                                TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter your email';
                                    }
                                    // return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle: GoogleFonts.portLligatSans(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 14,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    prefixIcon: const Icon(
                                      IconBroken.Message,
                                      color: Colors.purple,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'password too short';
                                    }
                                    //return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText:
                                      LoginCubit.get(context).isPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.portLligatSans(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      fontSize: 14,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    // suffix: Icon(RegisterCubit.get(context).suffix),
                                    prefixIcon: const Icon(
                                      IconBroken.Lock,
                                      color: Colors.purple,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        LoginCubit.get(context).suffix,
                                        color: Colors.purple,
                                      ),
                                      onPressed: () {
                                        LoginCubit.get(context)
                                            .changePasswordVisibility();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    if (formKey.currentState != null &&
                                        formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => SizedBox(
                                    width: double.infinity,
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState != null &&
                                            formKey.currentState!.validate()) {
                                          LoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                          print(emailController.text);
                                          print(passwordController.text);
//print('validated');
                                        } else {
                                          print('not validated');
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: GoogleFonts.portLligatSans(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: GoogleFonts.portLligatSans(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(context, RegisterScreen());
                                      },
                                      child: Text(
                                        'REGISTER',
                                        style: GoogleFonts.portLligatSans(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          fontSize: 15,
                                          color: Colors.purple,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
