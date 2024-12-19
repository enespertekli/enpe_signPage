import 'package:enpe_signup/auth/view/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'utils/constants/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1206, 2622),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
              title: 'Fiş Kesim',
              theme: ThemeData(
                primaryColor: PColors.white,
                primarySwatch: Colors.blue,
              ),
              home: SignupPage());
        });
  }
}
