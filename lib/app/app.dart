import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sorting_visualizer/app/app_binding.dart';
import 'package:sorting_visualizer/app/data/values/constants.dart';
import 'package:sorting_visualizer/app/data/values/env.dart';
import 'package:sorting_visualizer/app/routes/app_pages.dart';
import 'package:sorting_visualizer/app/theme/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Env.title,
      navigatorKey: GlobalKeys.navigationKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
    );
  }
}
