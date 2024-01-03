
  bool checkSecurePassword(String password) {
  // Verificar la longitud mínima de la contraseña
  if (password.length < 8) {
    return false;
  }

  // Verificar si la contraseña contiene al menos un número
  if (!password.contains(RegExp(r'\d'))) {
    return false;
  }

  // Verificar si la contraseña contiene al menos una letra en mayúscula
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Verificar si la contraseña contiene al menos una letra en minúscula
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // Verificar si la contraseña contiene al menos un carácter especial
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }

  // La contraseña cumple con todos los criterios de seguridad
  return true;
}