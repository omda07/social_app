import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/layout/social_screen.dart';
import 'package:messenger/modules/login/login_screen.dart';
import 'package:messenger/network/local/cache_helper.dart';
import 'package:messenger/shared/bloc_observer.dart';
import 'package:messenger/styles/theme.dart';

import 'network/constants.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Widget startWidget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    startWidget = const SocialScreen();
  } else {
    startWidget = LoginScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(startWidget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Messenger App',
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
