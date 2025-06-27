import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subtitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(title: 'Ejercicios', subtitle: 'Gestión de ejercicios', link: '/exercise', icon: Icons.fitness_center),
  MenuItem(title: 'Músculos', subtitle: 'Músculos ejercitados', link: '/muscle', icon: Icons.accessibility),
  MenuItem(title: 'Nueva sesión', subtitle: 'Agregar sets', link: '/session', icon: Icons.note_alt),
  MenuItem(title: 'Historial', subtitle: 'Sesiones pasadas', link: '/history', icon: Icons.history)
];