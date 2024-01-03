import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/config/app_theme.dart';
import 'package:task_manager/controllers/user_controller.dart';
import 'package:task_manager/model/model.dart';
import 'package:task_manager/services/services.dart';
import 'package:task_manager/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  UserController userCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userCtrl.user.value!.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Muestra el formulario cuando se presiona el botón
                showDialog(
                  context: context,
                  builder: (context) => _TaskForm(),
                );
              },
              child: const Text('Agregar Tarea'),
            ),
            _TaskList(uid: userCtrl.user.value!.uid),
          ],
        ),
      )
    );
  }
}

class _TaskList extends StatelessWidget {

  const _TaskList({required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TaskService().getTasks(uid),
      builder:(context, snapshot) {
        if(snapshot.hasError) return const Text('Ha ocurrido un error al cargar las tareas');
        if(snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

        List<Task> tasks = snapshot.data!;
        if(tasks.isEmpty) return const Center(child: Text('Todavía no tienes ninguna tarea guardada', style: AppTheme.h3Normal,));
        return Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              Task task = tasks[index];
              return Dismissible(
                key: Key(task.id),
                
                onDismissed:(direction) {
                  TaskService().deleteTask(task.id);
                },
                child: TaskContainer(task: task)
              );
            },
          ),
        );
      },
      );
  }
}

class _TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<_TaskForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showColorPicker();
              },
              style: ElevatedButton.styleFrom(primary: _selectedColor),
              child: const Text('Seleccionar Color'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Agregar lógica para guardar la tarea en la base de datos
                _saveTask();
              },
              child: const Text('Guardar Tarea'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showColorPicker() async {
    await ColorPicker(
      color: _selectedColor,
      onColorChanged: (Color value) {
        setState(() {
          _selectedColor = value;
        });
      },
      width: 40,
      height: 40,
      borderRadius: 10,
      spacing: 5,
      runSpacing: 5,
      columnSpacing: 5,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.accent: false,
        ColorPickerType.primary: false,
        ColorPickerType.both: true
      },
    ).showPickerDialog(
      context,
      constraints: const BoxConstraints(
        minHeight: 460,
        minWidth: 300,
        maxWidth: 320,
      ),
    );
  }

  void _saveTask() async {
    // Agregar lógica para guardar la tarea en la base de datos
    // Utilizar _nameController.text, _descriptionController.text y _selectedColor
    // para crear una instancia de Task y guardarla en la base de datos
    UserController userCtrl = Get.find();
    Task task = Task(
      color: _selectedColor, 
      name: _nameController.text, 
      description: _descriptionController.text,
      date: DateTime.now(),
      id: '',
      uid: userCtrl.user.value != null ? userCtrl.user.value!.uid : ''
    );
    String errorMessage = await TaskService().addTask(task);

    if(errorMessage != '') {
      // ignore: use_build_context_synchronously
      showDialog(context: context, builder:(context) {
        return AlertDialog(
          title: Text(errorMessage),
          actions: [ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Aceptar'))],
        );
      },);
    }else{
      Get.back();
    }
  }
}