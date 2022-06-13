

abstract class SocialRegisterStates{}

class SocialRegisterrInitialState extends SocialRegisterStates{}

class SocialRegisterrLoadingState extends SocialRegisterStates{}
class SocialRegisterrSuccessState extends SocialRegisterStates{

}
class SocialRegisterrErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterrErrorState(this.error);

}
class SocialUserCreateSuccessState extends SocialRegisterStates{

}
class SocialUserCreateErrorState extends SocialRegisterStates{
  final String error;
  SocialUserCreateErrorState(this.error);

}

class SocialRegisterrChangeVisibilityState extends SocialRegisterStates{}

