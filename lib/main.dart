import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/splash_page.dart';
import 'package:eqinsurance/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.dataTheme(),
        getPages: GetListPages.singleton.listPage(),
        home: SplashPage()
    );
  }
}
