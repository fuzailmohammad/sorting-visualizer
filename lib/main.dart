import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sorting_visualizer/app/app.dart';

void main() async {
  await initGetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

Future initGetStorage() async {
  await GetStorage.init();
}
