import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            TextButton(
              onPressed: () {
                if (SocialCubit.get(context).postImage == null) {
                  SocialCubit.get(context).createPost(
                    context: context,
                    text: textController.text,
                    dateTime: DateTime.now().toString(),
                  );
                  // navigateAndFinish(context, SocialScreen());
                } else {
                  SocialCubit.get(context).uploadPostImage(
                    text: textController.text,
                    dateTime: DateTime.now().toString(),
                    context: context,
                  );
                  textController.clear();
                  // navigateAndFinish(context, SocialScreen());
                }
              },
              child: const Text('POST'),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      // backgroundImage: AssetImage('assets/images/noImage.png'),
                      backgroundImage: profileImage == null
                          ? NetworkImage(
                              userModel!.image!,
                            )
                          : FileImage(profileImage) as ImageProvider,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        userModel!.name,
                        style: const TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'what is on your mind ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 250.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            scale: 1.0,
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 18.0,
                          child: IconButton(
                            iconSize: 18,
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: const Icon(
                              IconBroken.Close_Square,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
