import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/components/components.dart';
import 'package:messenger/layout/cubit/states.dart';
import 'package:messenger/layout/social_screen.dart';
import 'package:messenger/models/social_user_model/message_model.dart';
import 'package:messenger/models/social_user_model/post_model.dart';
import 'package:messenger/models/social_user_model/user_model.dart';
import 'package:messenger/modules/chats/chats_screen.dart';
import 'package:messenger/modules/feeds/feeds_screen.dart';
import 'package:messenger/modules/settings/settings_screen.dart';
import 'package:messenger/modules/users/users_screen.dart';
import 'package:messenger/network/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialGetUserInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> title = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      print(currentIndex);
      emit(SocialChangeBottomNavState());
    }
  }

  UserModel? userModel;

  Future<void> getUserData() async {
    emit(SocialGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.uId);
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      emit(SocialProfileImagePickedErrorState());

      print('no image selected');
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      emit(SocialCoverImagePickedErrorState());

      print('no image selected');
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(SocialUserUpdateLoadingState());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio, profile: value);
      }).catchError((onError) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(SocialUserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((onError) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((onError) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUserData(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) async {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: profile ?? userModel!.image,
      uId: userModel!.uId,
      bio: bio,
      isEmailVerified: false,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImagePostSuccessState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      emit(SocialPostImagePickedErrorState());

      print('no image selected');
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
    required BuildContext context,
  }) async {
    emit(SocialCreatePostLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          context: context,
          text: text,
          dateTime: dateTime,
          imagePost: value,
        );
        //  updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((onError) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost(
      {required String text,
      required String dateTime,
      String? imagePost,
      required BuildContext context}) async {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      imagePost: imagePost ?? '',
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      navigateAndFinish(context, SocialScreen());
      removePostImage();
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  Future<void> getPosts() async {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      postsId = [];
      posts = [];

      for (var element in event.docs) {
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((onError) {
          print(onError.toString());
        });
      }
      emit(SocialGetPostsSuccessState());
    });
  }

  void postLike(String postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialPostUserLikeSuccessState());
    }).catchError((onError) {
      emit(SocialPostUserLikeErrorState(onError.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() async {
    if (users.isEmpty) {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((onError) {
        emit(SocialGetAllUsersErrorState(onError.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }

      emit(SocialGetMessagesSuccessState());
    });
  }

  // Future<void> getDataNow() async {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     postsId = [];
  //     posts = [];
  //
  //     for (var element in event.docs) {
  //       postsId.add(element.id);
  //       posts.add(PostModel.fromJson(element.data()));
  //       element.reference.collection('likes').get().then((value) {
  //         likes.add(value.docs.length);
  //       });
  //     }
  //     emit(SocialGetPostsSuccessState());
  //   });
  // }
}
