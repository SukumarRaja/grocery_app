import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/file.dart';
import '../../themes/colors.dart';
import '../../widgets/camera_dialouge.dart';
import '../../widgets/common_text.dart';
import '../../widgets/common_textform_field.dart';
import '../../widgets/intl_phone_field.dart';
import 'login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonText(text: "Create Customer's Account"),
              const SizedBox(height: 10),
              Stack(children: [
                Obx(() => FileController.to.isPicked == true
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary,
                        backgroundImage:
                            MemoryImage(FileController.to.pickImage!),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary,
                      )),
                Positioned(
                    right: 0,
                    bottom: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        cameraDialog(context);
                      },
                    ))
              ]),
              const SizedBox(height: 35),
              Form(
                  key: AuthController.to.registerKey,
                  child: Column(
                    children: [
                      CommonTextFormField(
                        hintText: "Enter your name",
                        controller: AuthController.to.name,
                        validator: (data) {
                          if (data!.isEmpty || data == "") {
                            return "Name field required";
                          } else if (data.length < 3) {
                            return "Name atleast 3 character";
                          }
                          return null;
                        },
                      ),
                      CommonTextFormField(
                        hintText: "Enter your email",
                        controller: AuthController.to.email,
                        validator: (data) {
                          if (data!.isEmpty || data == "") {
                            return "Email field required";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntlPhoneField(
                          maxLength: 10,
                          hintText: "Phone",
                          controller: AuthController.to.phone,
                          initialCountryCode: "IN",
                          fontFamily: "Oswald",
                          validator: (data) {
                            if (data!.isEmpty || data == "") {
                              return "Phone field required";
                            } else if (data.length < 10) {
                              return "Phone number must be 10 character";
                            }
                            return null;
                          },
                        ),
                      ),
                      CommonTextFormField(
                        hintText: "Enter your password",
                        controller: AuthController.to.password,
                        obscureText: true,
                        validator: (data) {
                          if (data!.isEmpty || data == "") {
                            return "Password field required";
                          } else if (data.length < 6) {
                            return "Password atleast 6 character";
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => AuthController.to.showErrorMessage == true
                  ? const CommonText(
                      text: "Please fill all the required fields",
                      fontColor: AppColors.red,
                    )
                  : const SizedBox()),
              Obx(() => AuthController.to.showErrorMessage == true
                  ? const SizedBox(height: 20)
                  : const SizedBox()),
              Obx(() => AuthController.to.registerLoading == true
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : InkWell(
                      onTap: () {
                        if (AuthController.to.registerKey.currentState!
                            .validate()) {
                          // AuthController.to.showErrorMessage = false;
                          AuthController.to.register();
                        } else {
                          // AuthController.to.showErrorMessage = true;
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
                            text: "Register",
                            fontColor: AppColors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CommonText(text: "Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const Login());
                      },
                      child: const CommonText(
                        text: "Login",
                        fontColor: AppColors.primary,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
