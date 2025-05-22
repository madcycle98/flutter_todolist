import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/themes/todo_theme.dart';
import 'package:todo_list/ui/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  SupabaseService.initialize();

  final Directory hiveDbPath = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(hiveDbPath.path);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        home: SplashScreen(),
        theme: TodoTheme.lightMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
