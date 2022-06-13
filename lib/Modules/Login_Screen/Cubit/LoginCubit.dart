
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/Cubit/LoginStates.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/models/social_app/user_model.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);


  Future userLogin(
  {
  @required String email,
    @required String password,
}
      ) async{
    emit(SocialLoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user.email);
      print(value.user.uid);
      uid=value.user.uid;
      emit(SocialLoginSuccessState(value.user.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
    }

    IconData suffix = Icons.visibility_off_outlined;
    bool isShow = true;
  void changeVisibility(){
    isShow = !isShow;
    suffix = isShow?   Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialLoginChangeVisibilityState());
  }

  }
