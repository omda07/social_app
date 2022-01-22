import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/models/social_user_model/user_model.dart';
import 'package:messenger/modules/chats/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildItemChat(context, SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildItemChat(BuildContext context, UserModel model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          ChatDetailsScreen(
            userModel: model,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              // backgroundImage: ,
              backgroundImage: model.image!.isEmpty
                  ? const AssetImage('assets/images/noImage.png')
                  : NetworkImage(model.image!) as ImageProvider,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(height: 1.4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
