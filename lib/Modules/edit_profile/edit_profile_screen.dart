import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_cubit.dart';
import 'package:untitled3/Layout/social_layout/Cubit/social_states.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/icon_broken.dart';

class Edit_Profile_Screen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = SocialLayoutCubit.get(context).userModel;
        var profileimage = SocialLayoutCubit.get(context).profileImage;
        var coverimage = SocialLayoutCubit.get(context).coverImage;

        nameController.text = userData.name;
        bioController.text = userData.bio;
        phoneController.text = userData.phone;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', action: [
            defaultTextButton(
              function: () {
                SocialLayoutCubit.get(context).updateUserData(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text);
              },
              text: 'Update',
            ),
            SizedBox(
              width: 15.0,
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 220.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverimage == null
                                        ? NetworkImage(
                                            '${userData.cover}',
                                          )
                                        : FileImage(coverimage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialLayoutCubit.get(context)
                                        .getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 25.0,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileimage == null
                                    ? NetworkImage(
                                        '${userData.image}',
                                      )
                                    : FileImage(profileimage),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialLayoutCubit.get(context)
                                      .getProfileImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 14.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 20.0,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (SocialLayoutCubit.get(context).profileImage != null ||
                      SocialLayoutCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialLayoutCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  press: () {
                                    SocialLayoutCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                    SocialLayoutCubit.get(context).profileImage = null;
                                  },
                                  text: "Update profile",
                                ),
                                if(state is SocialLayoutUploadProfileImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (SocialLayoutCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  press: () {
                                    SocialLayoutCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                    SocialLayoutCubit.get(context).coverImage = null;
                                  },
                                  text: "Update Cover",
                                ),
                                if(state is SocialLayoutUploadCoverImageLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialLayoutCubit.get(context).profileImage != null ||
                      SocialLayoutCubit.get(context).coverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    conntroller: nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'name must not be Empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    conntroller: bioController,
                    type: TextInputType.text,
                    label: 'Bio',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Bio must not be Empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    conntroller: phoneController,
                    type: TextInputType.number,
                    label: 'Phone',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone must not be Empty';
                      }
                      return null;
                    },
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
