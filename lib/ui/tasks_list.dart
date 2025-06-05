import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/services/supabase_service.dart';
import 'package:todo_list/ui/single_task.dart';

import '../themes/todo_theme.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final SupabaseService _supabaseService = SupabaseService();
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<SingleTaskModel> personalTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchPersonalTasks();
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : personalTasks.isEmpty
          ? SizedBox(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/welcome_panda.jpeg', width: 280,),
            Text('Inserisci dei tasks per visualizzarli qui.'),
          ]
        ),
      )
          : ListView.builder(
              itemCount: personalTasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _openTaskModal(context, personalTasks[index]);
                  },
                  child: SingleTask(
                    title: personalTasks[index].title!,
                    description: personalTasks[index].description!
                  ),
                );
              }
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: TodoTheme.white,),
        onPressed: () {
          _openTaskModal(context);
        }
      ),
    );
  }

  Future _fetchPersonalTasks() async {
    setState(() {
      isLoading = true;
    });
    personalTasks = await _supabaseService.fetchTasks();
    setState(() {
      isLoading = false;
    });
  }

  void _openTaskModal(BuildContext context, [SingleTaskModel? singleTask]) {
    if (singleTask != null) {
      titleTEC.text = singleTask.title!;
      descriptionTEC.text = singleTask.description!;
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Form(
          key: formKey,
          child: Container(
            color: TodoTheme.white,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: titleTEC,
                    validator: (value) {
                      if (value == '') {
                        return "Inserisci un titolo";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'eg : Meeting with client',
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                  TextFormField(
                    controller: descriptionTEC,
                    validator: (value) {
                      if (value == '') {
                        return "Inserisci una descrizione";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Description',
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    maxLines: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Confermi l'eliminazione del task?",
                                            style: TextTheme.of(context).bodyMedium,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Annulla")
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _supabaseService.deleteTask(singleTask!.id!);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            titleTEC.text = '';
                                            descriptionTEC.text = '';
                                            await _fetchPersonalTasks();
                                          },
                                          child: Text("Elimina")
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            icon: Icon(
                              color: TodoTheme.red,
                              Icons.delete_forever
                            )
                        ),
                        IconButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()) {
                                if (singleTask == null) {
                                  await _supabaseService.insertTask(titleTEC.text, descriptionTEC.text);
                                } else {
                                  await _supabaseService.updateTask(singleTask.id!, titleTEC.text, descriptionTEC.text);
                                }
                                titleTEC.text = '';
                                descriptionTEC.text = '';
                                Navigator.of(context).pop();
                                await _fetchPersonalTasks();
                              }
                            },
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
            ),
          ),
        )
    );
  }
}
