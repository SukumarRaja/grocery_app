import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth.dart';
import '../../themes/colors.dart';
import '../../widgets/common_text.dart';
import '../../widgets/common_textform_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CommonText(text: "Login Customer's Account"),
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(height: 35),
            Form(
                key: AuthController.to.loginKey,
                child: Column(
                  children: [
                    CommonTextFormField(
                        hintText: "Enter your email",
                        controller: AuthController.to.lEmail,
                        validator: (data) {
                          if (data!.isEmpty || data == "") {
                            return "Email field required";
                          }
                          return null;
                        }),
                    CommonTextFormField(
                        hintText: "Enter your password",
                        obscureText: true,
                        controller: AuthController.to.lPassword,
                        validator: (data) {
                          if (data!.isEmpty || data == "") {
                            return "Password field required";
                          } else if (data.length < 6) {
                            return "Password atleast 6 character";
                          }
                          return null;
                        }),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => AuthController.to.loginLoading == true
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : InkWell(
                      onTap: () {
                        if (AuthController.to.loginKey.currentState!
                            .validate()) {
                          AuthController.to.login();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColors.primary),
                        child: const Center(
                          child: CommonText(
                            text: "Login",
                            fontColor: AppColors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonText(text: "Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const CommonText(
                      text: "Register",
                      fontColor: AppColors.primary,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
