import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: const InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 20.0))),
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 250.0),
                        const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Color(0xffFF5E5E),
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            key: controller.emailFormFieldKey,
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              hintText: '  Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: AppColors.middleGrey, width: 1.0),
                              ),
                            ), //박스모양
                            validator: controller.validateEmail,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                              key: controller.passwordFormFieldKey,
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.middleGrey, width: 1.0),
                                  ),
                                  hintText: '  Password'),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: controller.validatePassword),
                        ),
                        SizedBox(height: 10.0),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New user?',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  ButtonTheme(
                                    child: TextButton(
                                      onPressed: controller.navigateToRegister,
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                          foregroundColor: Color(0xffFF5E5E)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: controller.onSubmitPressed,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 38,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fixedSize: Size(38, 58),
                                  backgroundColor: Colors.red[300],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xffCCCCCC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  width: double.infinity,
                  color: Color(0xffCCCCCC),
                  child: Column(
                    children: [
                      Text(
                        'OR',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.onGooglePressed();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/google_logo.jpg'),
                                  ),
                                ),
                              ),
                              Text(
                                '  Sign in with google',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  width: double.infinity,
                  height: 167,
                  color: Color(0xffCCCCCC),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
