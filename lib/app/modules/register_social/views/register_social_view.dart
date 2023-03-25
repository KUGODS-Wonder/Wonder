import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/modules/widgets/checkbox_form_field.dart';

import '../controllers/register_social_controller.dart';

class RegisterSocialView extends GetView<RegisterSocialController> {
  const RegisterSocialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                const SizedBox(
                  height: 50,
                ),
                Row(
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
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red[300],
                        ),
                        child: const Text(
                          'check',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text('서울시'),
                    const SizedBox(width: 15),
                    Obx(() {
                        return DropdownButton<String>(
                          hint: const Text('Address'),
                          onChanged: (newValue) {
                            controller.selectedAddressItem.value = newValue as String;
                            controller.update();
                          },
                          value: controller.selectedAddressItem.value,
                          items: [
                            for (var data in controller.listType)
                              DropdownMenuItem(
                                value: data,
                                child: Text(data),
                              )
                          ]
                        );
                      }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 45),
                    const Text('to our', style: TextStyle(fontSize: 15)),
                    const SizedBox(width: 6),
                    SizedBox(
                      child: TextButton(
                        onPressed: controller.onSubmitPressed,
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
                const SizedBox(height: 20),
                SizedBox(
                    child: ElevatedButton(
                      onPressed: controller.submitRegister,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(38, 58),
                          backgroundColor: Colors.red[300]),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 38,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
