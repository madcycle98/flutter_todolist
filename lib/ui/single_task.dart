import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../themes/todo_theme.dart';

class SingleTask extends StatefulWidget {
  const SingleTask({super.key});

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
            padding: const EdgeInsets.only(top: 32.0),
            child: Container(
              width: 360,
              height: 40,
              decoration: BoxDecoration(
                  color: TodoTheme.backgroundGreen,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
              ),
            ),
          ),
          Container(
            width: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
              color: Color.fromRGBO(244, 244, 245, 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      spacing: 16,
                      children: [
                        IconButton(
                          onPressed:() {
                            _openTaskModal(context);
                          },
                          icon: Icon(Icons.add_box_rounded),
                          iconSize: 36,
                          color: TodoTheme.backgroundGreen,
                        ),
                        Text(
                            style: TextTheme.of(context).bodyMedium,
                            'Tap plus to create a new task.'
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            style: TextTheme.of(context).bodySmall,
                            'Add your task'
                        ),
                        Text(
                          style: TextTheme.of(context).bodySmall,
                          'Today, ${DateFormat('EEE dd MMM yyyy').format(DateTime.now())}',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
  }
}

void _openTaskModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'eg : Meeting with client',
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Description',
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                        color: TodoTheme.backgroundGreen,
                        Icons.send
                    )
                  )

                ],
              ),
            )
          ],
        ),
      )
    );
}

        // return AlertDialog(
        //   content: Column(
        //     children: [
        //       Form(child:
        //         Column(
        //           children: [
        //             TextFormField(
        //               keyboardType: TextInputType.text,
        //               decoration: InputDecoration(
        //                 hintText: 'eg: Meeting with client'
        //               ),
        //             ),
        //             TextFormField(
        //               keyboardType: TextInputType.text,
        //               decoration: InputDecoration(
        //                   hintText: 'Description'
        //               ),
        //             )
        //           ],
        //         )
        //       ),
        //     ],
        //   ),
        // );
        //       }
        //   );
        // }
