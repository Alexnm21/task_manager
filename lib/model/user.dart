class UserData {
  String email;
  String name;
  String uid;

  UserData({required this.email, required this.name, required this.uid});

  // Opcional: Método factory para crear una instancia de User desde un mapa (por ejemplo, al recibir datos de una base de datos)
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      uid: map['uid'] ?? ''
    );
  }

  // Opcional: Método para convertir la instancia de User a un mapa (por ejemplo, para guardar en una base de datos)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
    };
  }
}
