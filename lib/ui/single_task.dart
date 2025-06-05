import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/services/supabase_service.dart';

import '../themes/todo_theme.dart';

class SingleTask extends StatefulWidget {
  final String title;
  final String description;

  const SingleTask({
    super.key,
    required this.title,
    required this.description
  });

  @override
  State<SingleTask> createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: TodoTheme.backgroundGreen,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                  ),
                  child: Center(
                      child: Text(
                          widget.title,
                          style: TextTheme.of(context).headlineSmall!.copyWith(
                            color: TodoTheme.white
                          )
                      )
                  ),
                ),
                Container(
                  color: TodoTheme.backgroundGrey,
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: Text(widget.description, textAlign: TextAlign.start),
                )
              ],
            ),
          ),
        ],
      );
  }
}
