import 'package:flutter/material.dart';
import 'dart:ui';


class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: window.physicalSize.height / window.devicePixelRatio,
      padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
      decoration: BoxDecoration(color: Color(0xff0F0F12)),
      child: Text('tasks')
    );
  }
}
