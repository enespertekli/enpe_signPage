import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../utils/constants/colors.dart';
import '../../../widgets/button/pbutton.dart';
import '../../../widgets/textField/text_field.dart';
import '../../controller/signup/signup_controller.dart';
import '../login/login.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              child: Center(
                child: Image(
                  image: AssetImage(PImages.iconLogo),
                ),
              ),
            ),
            Text(
              PTexts.signUpTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              PTexts.loginSubTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: PSizes.spaceBtwInputFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    child: PTextField(
                      prefixIcon: Icons.person,
                      controller: controller.firstNameController,
                      text: PTexts.firstName,
                    ),
                  ),
                ),
                const SizedBox(width: PSizes.spaceBtwInputFields),
                Flexible(
                    child: SizedBox(
                        child: PTextField(
                            prefixIcon: Icons.person_outlined,
                            controller: controller.lastNameController,
                            text: PTexts.lastName))),
              ],
            ),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            PTextField(
                prefixIcon: Icons.email_outlined,
                controller: controller.emailController,
                text: PTexts.email),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            PTextField(
                prefixIcon: Icons.password,
                obscureText: true,
                controller: controller.passwordController,
                text: PTexts.password),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            PTextField(
                prefixIcon: Icons.password,
                obscureText: true,
                controller: controller.confirmPasswordController,
                text: PTexts.confirmPassword),
            const SizedBox(height: PSizes.spaceBtwInputFields),
            Obx(() {
              return PButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        await controller.registerUser();
                      },
                text: controller.isLoading.value ? "Loading..." : 'Kayıt Ol',
              );
            }),
            SizedBox(
                child: Center(
                    child: TextButton(
                        onPressed: () {
                          Get.to(() => LoginPage());
                        },
                        child: Text(
                          'Hesabım var',
                          style: Theme.of(context).textTheme.titleMedium,
                        ))))
          ],
        ),
      ),
    );
  }
}
