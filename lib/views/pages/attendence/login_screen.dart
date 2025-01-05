import 'package:attendance/core/controller/auth/login_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/common_text_field.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/validator.dart';
import 'package:attendance/views/widgets/common_button.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserLoginController loginController = Get.put(UserLoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      assetSvdImageWidget(
                          image: "asset/image/svg_image/login_illustration.svg",
                          height: 250),
                      Text(
                        "Welcome Back !.".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.cLabel,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            wordSpacing: 2.0),
                      ),
                      verticalSpace(10),
                      Text(
                        "Login in with punctuality, track your productivity".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.cLabel,
                          fontSize: 16,
                        ),
                      ),
                      verticalSpace(20),
                      CommonTextField(
                        controller: loginController.emailController,
                        labelText: 'Email',
                        hintText: "Enter Email".tr,
                        prefix: ImagePath.emailIcn,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          Validator.validateEmail(value);
                        },
                        validator: (value) {
                          return Validator.validateEmail(value!);
                        },
                      ),
                      verticalSpace(16),
                      CommonTextField(
                        controller: loginController.passwordController,
                        labelText: "Password".tr,
                        hintText: "Enter Password".tr,
                        prefix: ImagePath.lockIcn,
                        obscureText: loginController.isHiddenPassword.value,
                        obscuringCharacter: "*",
                        onChanged: (value) {
                          Validator.validatePassword(value);
                        },
                        validator: (value) {
                          return Validator.validatePassword(value!);
                        },
                        suffix: GestureDetector(
                          onTap: () {
                            loginController.isHiddenPassword.value = !loginController.isHiddenPassword.value;
                          },
                          child: Icon(
                            loginController.isHiddenPassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColor.cDarkGreyFont,
                          ),
                        ),
                      ),
                      verticalSpace(32),
                      CommonButton(
                          title: "Login",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginController.authLogin(email: loginController.emailController.text, password: loginController.passwordController.text);
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
