import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.sideBarBackground,
      child: const SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white30,
                child: Icon(CupertinoIcons.person, color: Colors.white,)
              ),
              title: Text('Nombre', style: AppTheme.h3Bold,),
              subtitle: Text('Perfil', style: AppTheme.h3Normal,),
            )
          ],
        ),
      ),
    );
  }
}