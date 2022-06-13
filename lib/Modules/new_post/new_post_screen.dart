import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/icon_broken.dart';

class New_Post extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = SocialLayoutCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              action: [
                defaultTextButton(
                    function: () {
                var date = DateTime.now();
                  if(SocialLayoutCubit.get(context).postImagE == null){
                    SocialLayoutCubit.get(context).createPost(date: date.toString(), text: textController.text);
                    Navigator.pop(context);
                  }
                  else{
                    SocialLayoutCubit.get(context).uploadPostImage(date: date.toString(), text: textController.text);
                    Navigator.pop(context);
                  }
              }, text: 'Post')]),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 5.0,),
                Row(
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
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 17.0,
                              )
                            ],
                          ),
                          Text(
                            'Public',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if(SocialLayoutCubit.get(context).postImagE != null)
                  Expanded(
                    child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialLayoutCubit.get(context).postImagE),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialLayoutCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 25.0,
                            ),
                          )),
                    ],
                ),
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialLayoutCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {

                        },
                        child:
                            Text(
                              '# tags',
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
