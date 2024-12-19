import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../widgets/button/pbutton.dart';
import '../../../widgets/textField/text_field.dart';
import '../../controller/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.white,
      appBar: AppBar(
        backgroundColor: PColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: PSizes.defaultSpace),
            Image(
              width: 600.w,
              image: const AssetImage(PImages.iconLogo),
            ),
            SizedBox(height: PSizes.defaultSpace),
            SizedBox(height: 150.w),
            PTextField(
              controller: controller.emailController,
              text: PTexts.email,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            Obx(
              () => PTextField(
                obscureText: controller.hidePassword.value,
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Icons.remove_red_eye
                        : Icons.panorama_fish_eye,
                    color: PColors.primary,
                  ),
                ),
                prefixIcon: Icons.password,
                controller: controller.passwordController,
                text: PTexts.password,
              ),
            ),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      PTexts.forgetPassword,
                      style: TextStyle(color: PColors.primary),
                    )),
                Row(
                  children: [
                    const Text(
                      PTexts.rememberMe,
                      style: TextStyle(color: PColors.primary),
                    ),
                    Obx(
                      () => Checkbox(
                          activeColor: PColors.primary,
                          checkColor: PColors.white,
                          side: const BorderSide(color: PColors.primary),
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                  ],
                ),
              ],
            ),
            PButton(
              onPressed: () {
                controller.emailAndPasswordLogIn();
              },
              text: PTexts.logIn,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
