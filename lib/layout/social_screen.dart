import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/modules/login/login_screen.dart';
import 'package:messenger/modules/new_post/new_post_screen.dart';
import 'package:messenger/network/constants.dart';
import 'package:messenger/styles/icon_broken.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, const NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: const Icon(IconBroken.Notification),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(IconBroken.Search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(IconBroken.Logout),
                onPressed: () {
                  signOut();
                  navigateAndFinish(context, LoginScreen());
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.User),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
