import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/social_screen.dart';
import 'package:messenger/models/social_user_model/fade_animation.dart';
import 'package:messenger/modules/login/login_screen.dart';
import 'package:messenger/modules/register/cubit/cubit.dart';
import 'package:messenger/modules/register/cubit/states.dart';
import 'package:messenger/styles/icon_broken.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(context, SocialScreen());
          }
        },
        builder: (context, state) => Scaffold(
          body: Container(
            color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      FadeAnimation('REGISTER'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'register now to comumnicate with friends',
                        style: GoogleFonts.portLligatSans(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 20,
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
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter your name';
                                  }
                                  // return null;
                                },
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Display Name',
                                  labelStyle: GoogleFonts.portLligatSans(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 14,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  prefixIcon: const Icon(
                                    IconBroken.Profile,
                                    color: Colors.purple,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter your email address';
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
                                    RegisterCubit.get(context).isPassword,
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
                                      RegisterCubit.get(context).suffix,
                                      color: Colors.purple,
                                    ),
                                    onPressed: () {
                                      RegisterCubit.get(context)
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
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              TextFormField(
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter your phone number';
                                  }
                                  // return null;
                                },
                                keyboardType: TextInputType.phone,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: GoogleFonts.portLligatSans(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 14,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  prefixIcon: const Icon(
                                    IconBroken.Call,
                                    color: Colors.purple,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => SizedBox(
                                  width: double.infinity,
                                  height: 50,
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
                                        RegisterCubit.get(context).userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text);
                                        print(emailController.text);
                                        print(passwordController.text);
                                      } else {
                                        print('not validated');
                                      }
                                    },
                                    child: Text(
                                      'Register Now',
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
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, LoginScreen());
                                },
                                child: Text(
                                  'Back',
                                  style: GoogleFonts.portLligatSans(
                                    textStyle:
                                        Theme.of(context).textTheme.headline4,
                                    fontSize: 15,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
