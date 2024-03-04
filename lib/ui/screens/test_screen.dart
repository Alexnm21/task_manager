import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/side_bar.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SideBar()
    );
  }
}