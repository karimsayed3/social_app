import 'package:untitled3/models/social_app/user_model.dart';

abstract class SocialLayoutStates{}

class SocialInitialState extends SocialLayoutStates{}

class SocialGetUserSuccessState extends SocialLayoutStates{
  final SocialUserModel model;

  SocialGetUserSuccessState(this.model);
}
class SocialGetUserLoadingState extends SocialLayoutStates{}
class SocialGetUserErrorState extends SocialLayoutStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialLayoutChangeNavBarState extends SocialLayoutStates{}

class SocialLayoutGetProfileImageSuccessState extends SocialLayoutStates{}
class SocialLayoutGetProfileImageErrorState extends SocialLayoutStates{}
class SocialLayoutGetCoverImageSuccessState extends SocialLayoutStates{}
class SocialLayoutGetCoverImageErrorState extends SocialLayoutStates{}
class SocialLayoutUploadProfileImageSuccessState extends SocialLayoutStates{}
class SocialLayoutUploadProfileImageLoadingState extends SocialLayoutStates{}
class SocialLayoutUploadProfileImageErrorState extends SocialLayoutStates{}
class SocialLayoutUploadCoverImageSuccessState extends SocialLayoutStates{}
class SocialLayoutUploadCoverImageLoadingState extends SocialLayoutStates{}
class SocialLayoutUploadCoverImageErrorState extends SocialLayoutStates{}


class SocialUpdateUserDataSuccessState extends SocialLayoutStates{
  final SocialUserModel model;

  SocialUpdateUserDataSuccessState(this.model);
}
class SocialUpdateUserDataLoadingState extends SocialLayoutStates{}
class SocialUpdateUserDataErrorState extends SocialLayoutStates{
  final String error;

  SocialUpdateUserDataErrorState(this.error);
}

// create post
class SocialCreatePostLoadingState extends SocialLayoutStates{}
class SocialCreatePostErrorState extends SocialLayoutStates{}
class SocialCreatePostSuccessState extends SocialLayoutStates{}

class SocialGetPostLoadingState extends SocialLayoutStates{}
class SocialGetPostErrorState extends SocialLayoutStates{}
class SocialGetPostSuccessState extends SocialLayoutStates{}
class SocialGetAllUserLoadingState extends SocialLayoutStates{}
class SocialGetAllUserErrorState extends SocialLayoutStates{}
class SocialGetAllUserSuccessState extends SocialLayoutStates{}

class SocialLayoutGetPostImageSuccessState extends SocialLayoutStates{}
class SocialLayoutGetPostImageErrorState extends SocialLayoutStates{}
class SocialRemovePostImageState extends SocialLayoutStates{}

class SocialLikePostErrorState extends SocialLayoutStates{}
class SocialLikePostSuccessState extends SocialLayoutStates{}
class SocialCommentPostSuccessState extends SocialLayoutStates{}
class SocialCommentPostErrorState extends SocialLayoutStates{}

class SocialSendMyMessageErrorState extends SocialLayoutStates{}
class SocialSendYourMessageErrorState extends SocialLayoutStates{}
class SocialSendMyMessageSuccessState extends SocialLayoutStates{}
class SocialSendYourMessageSuccessState extends SocialLayoutStates{}
class SocialGetMessageErrorState extends SocialLayoutStates{}
class SocialGetMessageSuccessState extends SocialLayoutStates{}

