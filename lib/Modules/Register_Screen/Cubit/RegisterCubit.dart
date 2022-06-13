import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Modules/social_app/Register_Screen/Cubit/RegisterStates.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/models/social_app/user_model.dart';



class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterrInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  Future Register({
    @required String email,
    @required String phone,
    @required String name,
    @required String password,
  }) async{
    print("hello");
    emit(SocialRegisterrLoadingState());

     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,).then((value) {
      userCreate(
        name: name,
        phone: phone,
        uId: value.user.uid,
        email: email,
      );
    }).catchError((error){
      print(error.toString());
      emit(SocialRegisterrErrorState(error.toString()));
    });
  }
  
  Future userCreate({
    @required String name,
    @required String email,
    @required String uId,
    @required String phone,
  })async{

    SocialUserModel model = await SocialUserModel(
      name : name,
      phone : phone,
      email : email,
      uId : uId,
      cover: 'https://image.freepik.com/free-vector/university-campus-library-facade-with-students-diversity-multiracial-young-men-women-with-boo_107791-7501.jpg',
      image: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
      isEmailVerified : false,
      bio: 'write your bio ...',
    );

    await FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      uid = model.uId;
      emit(SocialUserCreateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }

  
  IconData suffix = Icons.visibility_off_outlined;
  bool isShow = true;
  void changeVisibility(){
    isShow = !isShow;
    suffix = isShow?   Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterrChangeVisibilityState());
  }

  Future signOut()
  async{
    FirebaseAuth.instance.signOut();
  }
}
