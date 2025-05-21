import 'package:flutter/material.dart';
import 'package:todo_list/services/hive_services.dart';
import '../themes/todo_theme.dart';
import 'login_screen.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveService _hiveService = HiveService();
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(),
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
                Image.asset('assets/images/onb_img2.png'),
                Text(
                  'Find the practicality in making your todo list',
                  style: TextTheme.of(context).headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Easy-to-understand user interface  that makes you more comfortable when you want to create a task or to do list, Todyapp can also improve productivity',
                  style: TextTheme.of(context).bodySmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _hiveService.write(key: 'onBoardingDone', value: 'ok');
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              child: Text('Continue')
            )
          ],
        ),
      ),
    );
  }
}
