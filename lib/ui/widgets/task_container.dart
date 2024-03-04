import 'package:flutter/material.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/domain/entities/model.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: task.color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0,2), )]
      ),
      
      child: Text(task.name, style: AppTheme.h2Bold,),
    );
  }
}