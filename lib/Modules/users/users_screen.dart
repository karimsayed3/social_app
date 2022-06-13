import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';

class Users_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var userData = SocialLayoutCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: SocialLayoutCubit.get(context).users.length > 0,
          builder: (context)=> ListView.separated(
              itemBuilder: (context,index)=>buildChatItem(SocialLayoutCubit.get(context).users[index]),
              separatorBuilder: (context,index) => Container(
                width: double.infinity,
                height: 5.0,
              ),
              itemCount:  SocialLayoutCubit.get(context).users.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildChatItem(userData)=>InkWell(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              '${userData.image}',
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${userData.name}',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }

