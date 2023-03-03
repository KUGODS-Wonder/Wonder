import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 221),
            Column(
              children: [
                Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xffFF5E5E),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      // controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '  Email'), //박스모양
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) {
                          return 'The email is not in valid format';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: '  Nickname'),
                        keyboardType: TextInputType.text, //닉네임 인풋으로 바꿔야
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'check',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red[300],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.warning_amber_sharp),
                //     Text(
                //       'Nickname is a required field',
                //       style: TextStyle(
                //         color: Color(0xffFF8585),
                //       ),
                //     ),
                //   ],
                // ),
                Center(
                  child: Container(
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '  Password'),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.warning_amber_sharp),
                //     Text(
                //       'Password is a required field',
                //       style: TextStyle(
                //         color: Color(0xffFF8585),
                //       ),
                //     ),
                //   ],
                // ),
                Center(
                  child: Container(
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '  Password Confirm'),
                      keyboardType: TextInputType.text, //닉네임 인풋으로 바꿔야
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.warning_amber_sharp),
                //     Text(
                //       'Password does not match',
                //       style: TextStyle(
                //         color: Color(0xffFF8585),
                //       ),
                //     ),
                //   ],
                // ),
                Center(
                  child: Container(
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: '  Adress'),
                      keyboardType: TextInputType.emailAddress, //닉네임 인풋으로 바꿔야
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                //약관 동의?
                SizedBox(
                    child: ElevatedButton(
                  onPressed: () {},
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
                      backgroundColor: Colors.red[300]),
                )), //화살표 버튼
              ], //이메일 닉네임 패스워드 유형 정해야
            ),
          ],
        ),
      ),
    );
  }
}
