import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =  SocialLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currenIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search))
            ],
          ),
          body: cubit.screen[cubit.currenIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currenIndex,
            onTap: (index){
              cubit.changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: "Chats"),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: "Users"),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
