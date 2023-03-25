import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wonder_flutter/app/common/values/app_colors.dart';
import 'package:wonder_flutter/app/modules/register/controllers/register_controller.dart';

class GoogleRegisterView extends GetView<RegisterController> {
  const GoogleRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.kPrimary100,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
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
                  DropdownButton<String>(
                      hint: Text('Address'),
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
                      ]),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //체크박스
                  SizedBox(
                  width: 20,
                  height: 20,
                  child: CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.red[200],
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: controller.isCheckBoxChecked.value,
                    onChanged: (val) {
                      controller.isCheckBoxChecked.value = val!;
                    }),
                  ),
                  const SizedBox(width: 20),
                  const Text('By checking this box, you agree', style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 45,
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
              const SizedBox(
                height: 20,
              ),
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
