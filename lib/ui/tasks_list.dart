import 'package:flutter/material.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/ui/login_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final SupabaseService _supabaseService = SupabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
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
      ),
    );
  }
}
