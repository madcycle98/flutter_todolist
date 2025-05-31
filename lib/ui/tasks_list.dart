import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/ui/login_screen.dart';
import 'package:todo_list/ui/single_task.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../themes/todo_theme.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final SupabaseService _supabaseService = SupabaseService();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: TextTheme.of(context).headlineMedium,
              'Today',
            ),
            Text(
              style: TextTheme.of(context).bodySmall,
              'Best platform for creating to-do lists'
            )
          ],),
        ),
      body:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SingleTask()
        ),
      ),
      bottomNavigationBar:
        ElevatedButton(
          onPressed: () async {
            try {
              await _supabaseService.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginScreen()));
            } catch (error) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message:
                    error.toString(),
                ),
              );
            }
          },
          child: Text("Esci")
        ),
      );
  }
}
