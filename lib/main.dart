import 'package:eqinsurance/get_pages.dart';
import 'package:eqinsurance/theme/dark_theme.dart';
import 'package:eqinsurance/theme/light_theme.dart';
import 'package:eqinsurance/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
        //Your other providers goes here...
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeObject, _) => GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: LightTheme.dataTheme(),
          darkTheme: DarkTheme.dataTheme(),
          themeMode: themeObject.mode,
          getPages: GetListPages.singleton.listPage(),
          initialRoute: GetListPages.singleton.HOME,
        )
      ),
    );
  }
}
