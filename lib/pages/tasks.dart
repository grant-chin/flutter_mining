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
      child: Column(
        children: [
          Image.asset('assets/images/tasks/task_title.png'),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/tasks/turntable.png',
                width: MediaQuery.of(context).size.width - 96,
                height: MediaQuery.of(context).size.width - 96,
              )
            ]
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              children: [
                Image.asset('assets/images/tasks/task_list.png'),

              ],
            ),
          )
        ],
      )
    );
  }
}
