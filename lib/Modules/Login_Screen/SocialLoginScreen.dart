import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Layout/social_layout/social_layout.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/Cubit/LoginCubit.dart';
import 'package:untitled3/Modules/social_app/Login_Screen/Cubit/LoginStates.dart';
import 'package:untitled3/Modules/social_app/Register_Screen/SocialRegisterScreen.dart';
import 'package:untitled3/components.dart';
import 'package:untitled3/remote/dio/casheHelper.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
        create: (context) => SocialLoginCubit(),
        child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
            if(state is SocialLoginErrorState){
              toast(msg: state.error, state: ToastState.ERROR);
            }
            if(state is SocialLoginSuccessState){
              cacheHelper.saveData(
                key: 'uId',
                value: state.uId,
              ).then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SocialLayout()),
                        (route) => false);
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Login Screen'),
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
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Login now and communicate with friends',
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
                              conntroller: passwordController,
                              type: TextInputType.visiblePassword,
                              isPassword: SocialLoginCubit.get(context).isShow,
                              label: 'password',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                              prefix: Icons.lock_outline,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubit.get(context).changeVisibility();
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              press: () {
                                if (formKey.currentState.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: usernameController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              radius: 10.0,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\`t have account?',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              defaultTextButton(
                                text: 'Register Now',
                                function: () {
                                  Navegato(context, SocialRegisterScreen());
                                },
                              )
                            ],
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
