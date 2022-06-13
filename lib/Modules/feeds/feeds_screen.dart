import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/Modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled3/models/social_app/post_model.dart';
import 'package:untitled3/models/social_app/user_model.dart';
import 'package:untitled3/remote/icon_broken.dart';

class Feeds_Screen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = SocialLayoutCubit.get(context).userModel;

        return ConditionalBuilder(
          condition: SocialLayoutCubit.get(context).posts.length > 0 &&
              SocialLayoutCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(
                      '${userData.cover}',
                    ),
                    fit: BoxFit.cover,
                    height: 90.0,
                    width: double.infinity,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => New_Post()));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Paper_Upload,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'write what in your mind ...',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                          '${userData.image}',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(context,
                      SocialLayoutCubit.get(context).posts[index], index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5.0,
                  ),
                  itemCount: SocialLayoutCubit.get(context).posts.length,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel userData, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          '${userData.date}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                    ),
                  )
                ],
              ),
              //divider between post and heder
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              ////////
              Text(
                '${userData.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Container(
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20.0,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           height: 25.0,
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: Text(
              //             '#software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (userData.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10.0),
                  child: Container(
                    height: 160.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://image.freepik.com/free-vector/university-campus-library-facade-with-students-diversity-multiracial-young-men-women-with-boo_107791-7501.jpg',
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialLayoutCubit.get(context).likePost(
                              SocialLayoutCubit.get(context).postId[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 22.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialLayoutCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 22.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialLayoutCubit.get(context).comments[index]} comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            '${SocialLayoutCubit.get(context).userModel.image}',
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Container(
                            width: 120.0,
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: 'Write a Comment',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            SocialLayoutCubit.get(context).commentPost(SocialLayoutCubit.get(context).postId[index],textController.text);
                            textController.text = '';
                          },
                          icon: Icon(IconBroken.Arrow___Right_Square),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
