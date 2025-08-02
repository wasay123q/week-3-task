import 'package:flutter/material.dart';
import '../models/task_filter.dart';

class FilterDropdown extends StatelessWidget {
  final TaskFilter selectedFilter;
  final Function(TaskFilter) onFilterChanged;

  const FilterDropdown({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6750A4).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF6750A4).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TaskFilter>(
          value: selectedFilter,
          onChanged: (TaskFilter? newValue) {
            if (newValue != null) {
              onFilterChanged(newValue);
            }
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: const Color(0xFF6750A4),
            size: 24,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          items: TaskFilter.values.map((TaskFilter filter) {
            return DropdownMenuItem<TaskFilter>(
              value: filter,
              child: Row(
                children: [
                  Icon(
                    filter.icon,
                    color: const Color(0xFF6750A4),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    filter.label,
                    style: const TextStyle(
                      color: Color(0xFF6750A4),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return TaskFilter.values.map((TaskFilter filter) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filter.icon,
                      color: const Color(0xFF6750A4),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        filter.label,
                        style: const TextStyle(
                          color: Color(0xFF6750A4),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
} 