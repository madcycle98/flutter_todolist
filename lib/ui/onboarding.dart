import 'package:flutter/material.dart';
import 'package:todo_list/services/hive_services.dart';
import '../themes/todo_theme.dart';
import 'login_screen.dart';
import 'onboarding2.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveService hiveService = HiveService();
    double screenWidth = MediaQuery.sizeOf(context).width;
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,24,0),
            child: GestureDetector(
              onTap: () {
                hiveService.write(key: 'onBoardingDone', value: 'ok');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              child: Text(
                  'Skip',
                  style: TextTheme.of(context).bodyMedium!.copyWith(
                    color: TodoTheme.backgroundGreen
                  ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Image.asset('assets/images/onb_img.png'),
                Text(
                    'Your convenience in making a todo list',
                    style: TextTheme.of(context).headlineMedium,
                    textAlign: TextAlign.center,
                ),
                Text(
                    'Here\'s a mobile platform that helps you create task or to list so that it can help you in every job easier and faster.',
                    style: TextTheme.of(context).bodySmall,
                    textAlign: TextAlign.center,
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => Onboarding2()));
                },
                child: Text('Continue')
            )
          ],
        ),
      ),
    );
  }
}
