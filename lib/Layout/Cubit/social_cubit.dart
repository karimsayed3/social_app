
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/Cubit/LoginStates.dart';
import 'package:untitled3/Modules/social_app/Register_Screen/Cubit/RegisterStates.dart';
import 'package:untitled3/Modules/social_app/chats/chat_screen.dart';
import 'package:untitled3/Modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled3/Modules/social_app/settings/settings_screen.dart';
import 'package:untitled3/Modules/social_app/users/users_screen.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/models/social_app/message_model.dart';
import 'package:untitled3/models/social_app/post_model.dart';
import 'package:untitled3/models/social_app/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(SocialInitialState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
          print(value.data());
          userModel = SocialUserModel.fromJson(value.data());
          emit(SocialGetUserSuccessState(userModel));
    })
        .catchError((error) {
          emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currenIndex =0;
  void changeNavBar(int index){
    if(index ==1)
      getUsers();
    currenIndex = index;
    emit(SocialLayoutChangeNavBarState());
  }

  List<Widget> screen =[
    Feeds_Screen(),
    Chat_Screen(),
    Users_Screen(),
    Settings_Screen(),
  ];

  List<String> title =[
    "Home",
    "Chats",
    "Users",
    "Settings",
  ];

  File profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialLayoutGetProfileImageSuccessState());
    }else
    {
      print("No Image Selected");
      emit(SocialLayoutGetProfileImageErrorState());

    }
  }

  File coverImage;
  Future<void> getCoverImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(SocialLayoutGetCoverImageSuccessState());

    }else
    {
      print("No Image Selected");
      emit(SocialLayoutGetCoverImageErrorState());

    }
  }



  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }){
    emit(SocialUpdateUserDataLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUserData(
              name : name,
              phone : phone ,
              bio : bio,
              profile: value,
            );
          }).catchError((error){
            print(error.toString());
            emit(SocialLayoutUploadProfileImageErrorState());
          });
    }).catchError((error){
      print(error.toString());

    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
}){
    emit(SocialUpdateUserDataLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUserData(
              name : name,
              phone : phone ,
              bio : bio,
              cover: value,
            );
          }).catchError((error){
            print(error.toString());
            emit(SocialLayoutUploadCoverImageErrorState());

          });
    }).catchError((error){
      print(error.toString());
      emit(SocialLayoutUploadCoverImageErrorState());

    });
  }

  // void updateUserImages(
  //     {
  //       @required String name,
  //       @required String phone,
  //       @required String bio,
  //     }
  //     ){
  //   emit(SocialUpdateUserDataLoadingState());
  //   if(coverImage != null){
  //     uploadCoverImage();
  //   }
  //   else if(profileImage != null){
  //     uploadProfileImage();
  //   }else if(profileImage != null && coverImage != null){
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   }
  //   else{
  //     updateUserData(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //
  //   }
  //
  // }

  void updateUserData(  {
    @required String name,
    @required String phone,
    @required String bio,
    String profile,
    String cover,
  }
      ){
    emit(SocialUpdateUserDataLoadingState());

    SocialUserModel model = SocialUserModel(
      name : name,
      phone : phone,
      cover: cover?? userModel.cover,
      image: profile?? userModel.image,
      email: userModel.email,
      uId: userModel.uId,
      isEmailVerified : false,
      bio: bio,
    );

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(SocialUpdateUserDataErrorState(error.toString()));
    });
  }





  File postImagE;
  Future<void> getPostImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null){
      postImagE = File(pickedFile.path);
      emit(SocialLayoutGetPostImageSuccessState());
    }else
    {
      print("No Image Selected");
      emit(SocialLayoutGetPostImageErrorState());

    }
  }
  void removePostImage(){
    postImagE = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    @required String date,
    @required String text,
  }){
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImagE.path).pathSegments.last}')
        .putFile(postImagE)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          post: value,
          date: date,
        );
      }).catchError((error){
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      print(error.toString());
      emit(SocialCreatePostErrorState());

    });
  }

  void createPost(  {
    @required String date,
    String post,
    @required String text,
  }
      ){
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name : userModel.name,
      uId : userModel.uId,
      image: userModel.image,
      date: date,
      postImage: post??'',
      text: text,
    );

    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }


  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [] ;
  List<int>  comments = [];

  void getPosts(){
    emit(SocialGetPostLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value)
    {

      value.docs.forEach((element) {
        element.reference
            .collection('comments')
            .get().then((value) {
          comments.add(value.docs.length);
        });
      });

      value.docs.forEach((element) {
        element.reference
        .collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){

        });
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error){
      emit(SocialGetPostErrorState());
    });
  }



  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like':true})
        .then((value) {
          emit(SocialLikePostSuccessState());

    }).catchError((error){
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId,text){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel.uId)
        .set({'comment':text})
        .then((value) {
          emit(SocialCommentPostSuccessState());

    }).catchError((error){
      emit(SocialCommentPostErrorState());
    });
  }

  List<SocialUserModel> users = [];

  void getUsers(){
    emit(SocialGetAllUserLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      if(users.length ==0)
        value.docs.forEach((element) {
        if(element.data()['uId'] != userModel.uId)
          users.add(SocialUserModel.fromJson(element.data()));
       });
      emit(SocialGetAllUserSuccessState());
    }).catchError((error){
      emit(SocialGetAllUserErrorState());
    });
  }


  void sendMessage({
  @required String receiverId,
  @required String dateTime,
  @required String text,
}){
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel.uId,
      dateTime: dateTime,
      receiverId: receiverId,
    );

    FirebaseFirestore.instance.collection('users')
    .doc(userModel.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(model.toMap())
    .then((value) {
      emit(SocialSendYourMessageSuccessState());
    }).catchError((error){
      emit(SocialSendYourMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMyMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMyMessageErrorState());
    });
}

List<MessageModel> messages = [];

  void getMessage(
  {
    @required String receiverId,
  }
      ){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
          messages =[];
          event.docs.forEach((element) { 
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }

}
