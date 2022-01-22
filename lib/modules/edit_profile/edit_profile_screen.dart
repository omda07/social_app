import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/cubit/cubit.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: const Text('UPDATE'),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState ||
                      state is SocialGetPostsLoadingState)
                    const LinearProgressIndicator(),
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        //AssetImage('assets/images/noImage.png'),
                                        coverImage == null
                                            ? NetworkImage(
                                                userModel.cover!,
                                              )
                                            : FileImage(coverImage)
                                                as ImageProvider,
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
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:
                                    // AssetImage('assets/images/noImage.png'),
                                    profileImage == null
                                        ? NetworkImage(
                                            userModel.image!,
                                          )
                                        : FileImage(profileImage)
                                            as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 18.0,
                              child: IconButton(
                                iconSize: 18,
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text);
                                    },
                                    child: const Text('Upload Profile'),
                                  ),
                                ),
                                // const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    child: const Text('Upload cover'),
                                  ),
                                ),
                                //const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 15.0,
                  ),
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
                      label: const Text('Name'),
                      prefix: const Icon(
                        IconBroken.User,
                        color: Colors.purple,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'please enter your bio';
                      }
                      // return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: bioController,
                    decoration: InputDecoration(
                      label: const Text('Bio'),
                      prefix: const Icon(
                        IconBroken.Info_Circle,
                        color: Colors.purple,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                      label: const Text('Phone Number'),
                      prefix: const Icon(
                        IconBroken.Call,
                        color: Colors.purple,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
