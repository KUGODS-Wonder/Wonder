import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../register/views/register_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50)),
            Form(
              child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 20.0))),
                  child: Container(
                    padding: EdgeInsets.all(40.0),
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
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '  Email'), //박스모양
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
                                hintText: '  Password',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
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
                              ),
                            ),
                            ButtonTheme(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterView()),
                                  );
                                },
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    primary: Color(0xffFF5E5E)),
                              ),
                            ),
                            SizedBox(width: 18),
                            ElevatedButton(
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
                                backgroundColor: Colors.red[300],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  )),
            ),
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
            Container(
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
                      onPressed: () {},
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/google_logo.jpg'),
                              ),
                            ),
                          ),
                          Text(
                            '  Sign in with google',
                            style: TextStyle(color: Colors.black, fontSize: 17),
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
            Container(
              width: double.infinity,
              height: 167,
              color: Color(0xffCCCCCC),
              child: Align(
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
        ),
      ),
    );
  }
}
