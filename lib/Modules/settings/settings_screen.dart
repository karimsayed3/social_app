import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/Modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:untitled3/remote/icon_broken.dart';

class Settings_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = SocialLayoutCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 220.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${userData.cover}',
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    CircleAvatar(
                      radius: 63.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                          '${userData.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${userData.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userData.bio}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 16.0,
                    ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               Text(
              //                 '100',
              //                 style: Theme.of(context).textTheme.subtitle1,
              //               ),
              //               Text(
              //                 'post',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           fontSize: 14.0,
              //                         ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               Text(
              //                 '100',
              //                 style: Theme.of(context).textTheme.subtitle1,
              //               ),
              //               Text(
              //                 'post',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           fontSize: 14.0,
              //                         ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               Text(
              //                 '100',
              //                 style: Theme.of(context).textTheme.subtitle1,
              //               ),
              //               Text(
              //                 'post',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           fontSize: 14.0,
              //                         ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: InkWell(
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               Text(
              //                 '100',
              //                 style: Theme.of(context).textTheme.subtitle1,
              //               ),
              //               Text(
              //                 'post',
              //                 style:
              //                     Theme.of(context).textTheme.caption.copyWith(
              //                           fontSize: 14.0,
              //                         ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                          style: TextStyle(
                            color: Colors.blue
                          ),
                        ),
                  ),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Profile_Screen(),),);
                    },
                    child: Icon(
                      IconBroken.Edit,
                      color: Colors.blue,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
