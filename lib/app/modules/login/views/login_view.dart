import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 20.0))),
            child: Container(
              padding: EdgeInsets.all(40.0),
              // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
              // SingleChildScrollView으로 감싸 줌
              child: Column(
                children: [
                  SizedBox(
                    height: 250.0,
                  ),
                  Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Color(0xffFF5E5E),
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        //띄어쓰기
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '  Email'), //박스모양
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        //띄어쓰기
                        decoration: InputDecoration(
                          labelText: '  Password',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true, // 비밀번호 안보이도록 하는 것
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 150),
                      Text(
                        'New user?',
                        style: TextStyle(
                          fontSize: 20,
                        ), //sign up 버튼
                      ),
                      ButtonTheme(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                            ),
                          ),
                          style:
                              TextButton.styleFrom(primary: Color(0xffFF5E5E)),
                        ),
                      ), //화살표 버튼 옆으로 보내야
                      SizedBox(width: 15),
                      SizedBox(
                          width: 60,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[300]),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          )),
          Container(
            height: 25,
            decoration: BoxDecoration(
              color: Color(0xffCCCCCC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
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
                  Center(
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                          //구글 아이콘 prefixIcon: Icon(Icons.google),
                          border: InputBorder.none,
                          labelText: '  Sign in with Google',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ), //박스모양
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  //google 입력
                ],
              ),
              color: Color(0xffCCCCCC),
            ),
          ),
        ],
      ),
    );
  }
}
