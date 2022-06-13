import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/social_layout.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/SocialLoginScreen.dart';
import 'package:untitled3/Modules/social_app/Register_Screen/Cubit/RegisterCubit.dart';
import 'package:untitled3/Modules/social_app/Register_Screen/Cubit/RegisterStates.dart';
import '../../../components.dart';

import 'package:untitled3/remote/dio/casheHelper.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if(state is SocialUserCreateSuccessState){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SocialLayout()), (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Register Screen'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Register now and communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                            conntroller: usernameController,
                            type: TextInputType.text,
                            label: 'Enter Username',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter UserName';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                            conntroller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Email Addresses';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                            conntroller: phoneController,
                            type: TextInputType.phone,
                            label: 'Phone',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Telephone number';
                              }
                              return null;
                            },
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          defaultFormField(
                              conntroller: passwordController,
                              type: TextInputType.visiblePassword,
                              isPassword:
                                  SocialRegisterCubit.get(context).isShow,
                              label: 'password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                              prefix: Icons.lock_outline,
                              suffix: SocialRegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changeVisibility();
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterrLoadingState,
                            builder: (context) => defaultButton(
                              press: () {
                                if (formKey.currentState.validate()) {
                                  SocialRegisterCubit.get(context).Register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: usernameController.text,
                                  );
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SocialLoginScreen()), (route) => false);
                                }
                              },
                              text: 'Register',
                              radius: 10.0,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
