import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/services/hive_services.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/ui/login_screen.dart';
import 'package:todo_list/ui/onboarding.dart';
import 'package:todo_list/ui/tasks_list.dart';
import '../themes/todo_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SupabaseService _supabaseService = SupabaseService();
  final HiveService _hiveService = HiveService();

  Future navigateToOverboard() async {
    await Future.delayed(Duration(milliseconds: 3000));
    if (_supabaseService.client.auth.currentSession != null && !_supabaseService.client.auth.currentSession!.isExpired) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => TasksList()));
    } else {
      String? onBoardingOk = await _hiveService.read(key: 'onBoardingDone');
      if (onBoardingOk == 'ok') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => Onboarding()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    navigateToOverboard();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: TodoTheme.backgroundGreen,
      body: SizedBox(
        width: screenWidth,
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                  Icons.list_alt,
                  size: 46,
                color: TodoTheme.backgroundGreen,
              ),
            ),
            Text(
                'Todyapp',
                style: TextTheme.of(context).headlineMedium!.copyWith(
                  color: TodoTheme.white
                )
            ),
            Text(
                'The best to do list application for you',
              style: TextTheme.of(context).bodySmall!.copyWith(
                  color: TodoTheme.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
