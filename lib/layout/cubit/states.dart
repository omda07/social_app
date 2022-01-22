abstract class SocialStates {}

class SocialGetUserInitialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String Error;

  SocialGetUserErrorState(this.Error);
}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String Error;

  SocialGetAllUsersErrorState(this.Error);
}

class SocialPostUserLikeSuccessState extends SocialStates {}

class SocialPostUserLikeErrorState extends SocialStates {
  final String Error;

  SocialPostUserLikeErrorState(this.Error);
}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String Error;

  SocialGetPostsErrorState(this.Error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialRemoveImagePostSuccessState extends SocialStates {}
// chat

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}
