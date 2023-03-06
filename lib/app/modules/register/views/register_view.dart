import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/util/validators.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import '../controllers/register_controller.dart';

final RxInt selected = 0.obs;

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //single child scroll view 대신 쓰고 mainaxisalignment와 함께 사용 가능
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.kPrimary100,
                ),
              ),
              const SizedBox(height: 25),
              // 여기부터 바꾼 위젯.
              SizedBox(
                width: 250,
                child: TextFormField(
                  key: controller.emailFormFieldKey,
                  controller: controller.emailTextController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    hintText: '  Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: AppColors.middleGrey,
                        width: 1.0
                      ),
                    ),
                  ), //박스모양
                  validator: controller.validateEmail,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                child: Row(
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
                        keyboardType: TextInputType.text,
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
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 250,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                    key: controller.passwordFormFieldKey,
                    controller: controller.passwordTextController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '  Password'),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: Validators.validatePassword
                    ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: 250,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                    controller: controller.passwordConfirmTextController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: '  Password Confirm'),
                    keyboardType: TextInputType.text, //닉네임 인풋으로 바꿔야
                    obscureText: true,
                    validator: (passwordconfirm) {
                      //return Validators.validateConfirmPassword(
                      // passwordconfirm,);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
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
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 130),
                    //체크박스
                    Obx(
                      () => SizedBox(
                        width: 20,
                        height: 20,
                        child: CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.red[200],
                          controlAffinity: ListTileControlAffinity.leading,
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: selected.value == 1,
                          onChanged: (val) {
                            val ?? true ? selected.value = 1 : selected.value = 0;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'By checking this box, you agree',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 170,
                    ),
                    Text(
                      'to our',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Terms and Service',
                          style: TextStyle(fontSize: 18, color: Colors.red[200]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
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
                    backgroundColor: Colors.red[300]),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
