import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  final String id;
  final String uid;
  final String name;
  final String description;
  final DateTime date;
  final bool completed;
  final Color color;

  Task({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.color,
    required this.date,
    this.completed = false,
  });


  // Método para crear una instancia de Task a partir de un mapa
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] != null ? (map['date'] as Timestamp).toDate() : DateTime.now(),
      completed: map['completed'] ?? false,
      color: Color(map['color'] ?? 0),
    );
  }
  
}
