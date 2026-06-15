import 'package:flutter/material.dart';

class ProjectFeature {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const ProjectFeature({
    required this.icon,
    required this.title,
    required this.description,
    this.color = Colors.indigo,
  });
}
