import 'package:flutter/material.dart';

enum TaskFilter {
  all('All Tasks', Icons.list),
  completed('Completed Tasks', Icons.check_circle),
  uncompleted('Uncompleted Tasks', Icons.pending),
  highPriority('High Priority Tasks', Icons.priority_high);

  const TaskFilter(this.label, this.icon);
  
  final String label;
  final IconData icon;
} 