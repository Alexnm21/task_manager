import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/domain/entities/model.dart';

class TaskRepository {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Future<String> addTask(Task task) async {
    try {
      if(task.uid == '') throw Exception('No hay usuario para asiganarle la tarea');
      await _tasksCollection.add({
        'uid': task.uid,
        'name': task.name,
        'description': task.description,
        'date': task.date,
        'completed': task.completed,
        'color': task.color.value
      });

      return '';
    } catch (e) {
      String errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      return 'Error al agregar la tarea: $errorMessage';
    }
  }

  Future<List<Task>> getTasks(String uid) async {
    try {
      final querySnapshot = await _tasksCollection.where('uid', isEqualTo: uid).get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Task.fromMap(data);
      }).toList();
    } catch (e) {
      // Manejar el error según sea necesario
      print('Error al obtener las tareas: $e');
      return [];
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _tasksCollection.doc(task.id).update({
        'name': task.name,
        'description': task.description,
        'date': task.date,
        'completed': task.completed,
      });
    } catch (e) {
      // Manejar el error según sea necesario
      print('Error al actualizar la tarea: $e');
    }
  }

  Future<String> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
      return "";
    } catch (e) {
      // Manejar el error según sea necesario
      return "Error al eliminar la tarea";
    }
  }
}
