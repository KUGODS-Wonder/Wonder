import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/modules/widgets/checkbox_form_field.dart';
import '../controllers/register_controller.dart';


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
              SizedBox(
                width: 250,
                child: TextFormField(
                  key: controller.emailFormFieldKey,
                  controller: controller.emailTextController,
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
              const SizedBox(height: 25),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: TextFormField(
                        key: controller.nicknameFormFieldKey,
                        controller: controller.nicknameTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: AppColors.middleGrey, width: 1.0),
                          ),
                          hintText: '  Nickname',
                        ),
                        validator: controller.validateNickname,
                      ),
                    ),
                    SizedBox(width: 5),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: controller.onCheckPressed,
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
              const SizedBox(height: 25),
              SizedBox(
                width: 250,
                child: TextFormField(
                    key: controller.passwordFormFieldKey,
                    controller: controller.passwordTextController,
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
              const SizedBox(height: 25),
              SizedBox(
                width: 250,
                child: TextFormField(
                  controller: controller.passwordConfirmTextController,
                  key: controller.passwordConfirmFormFieldKey,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    hintText: '  Password Confirm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: AppColors.middleGrey, width: 1.0),
                    ),
                  ),
                  keyboardType: TextInputType.text, //닉네임 인풋으로 바꿔야
                  obscureText: true,
                  validator: controller.validatePasswordConfirm,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Address  ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('서울시'),
                  SizedBox(
                    width: 15,
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      hint: Text('Address'),
                      onChanged: (newValue) {
                        controller.setSelected(newValue!);
                      },
                      value: controller.selectedAddressItem.value,
                      items: controller.listType.map((selectedType) {
                        return DropdownMenuItem(
                          child: new Text(
                            selectedType,
                          ),
                          value: selectedType,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: 250,
                height: 100,
                child: CheckBoxFormField(
                  key: controller.checkBoxFormFieldKey,
                  checkColor: Colors.white,
                  activeColor: Colors.red[200],
                  initialValue: controller.isCheckBoxChecked.value,
                  validator: controller.validateCheckBox,
                  trailing: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'By checking this box, you agree to our ',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15
                          ),
                        ),
                        TextSpan(
                          text: 'Terms and Service',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red[200],
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.onTapTermsAndService,
                        ),
                      ],
                    ),
                  )
                ),
              ),
              const SizedBox(height: 25),
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
