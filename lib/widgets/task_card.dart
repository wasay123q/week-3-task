import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = task.isCompleted;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isCompleted
                ? LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.1),
                      Colors.green.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      const Color(0xFF6750A4), // Darker purple
                      const Color(0xFF8B5CF6), // Medium purple
                      const Color(0xFFA78BFA), // Lighter purple
                      const Color(0xFFC4B5FD), // Very light purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          ),
          child: Row(
            children: [
              // Checkbox
              GestureDetector(
                onTap: onToggle,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? Colors.green
                        : Colors.grey.withOpacity(0.3),
                    border: Border.all(
                      color: isCompleted
                          ? Colors.green
                          : Colors.grey.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Task content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                         Text(
                       task.title,
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                         color: isCompleted
                             ? Colors.grey[600]
                             : Colors.white,
                         decoration: isCompleted
                             ? TextDecoration.lineThrough
                             : null,
                       ),
                     ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                                             Text(
                         task.description,
                         style: TextStyle(
                           fontSize: 14,
                           color: isCompleted
                               ? Colors.grey[500]
                               : Colors.white.withOpacity(0.9),
                           decoration: isCompleted
                               ? TextDecoration.lineThrough
                               : null,
                         ),
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                       ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                                                 Icon(
                           Icons.schedule,
                           size: 14,
                           color: isCompleted
                               ? Colors.grey[500]
                               : Colors.white.withOpacity(0.7),
                         ),
                        const SizedBox(width: 4),
                                                 Text(
                           DateFormat('MMM dd, yyyy').format(task.createdAt),
                           style: TextStyle(
                             fontSize: 12,
                             color: isCompleted
                                 ? Colors.grey[500]
                                 : Colors.white.withOpacity(0.7),
                           ),
                         ),
                        if (task.completedAt != null) ...[
                          const SizedBox(width: 16),
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.green[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Completed ${DateFormat('MMM dd').format(task.completedAt!)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
                             // Edit icon
               GestureDetector(
                 onTap: onTap,
                 child: Container(
                   padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: Colors.white.withOpacity(0.2),
                   ),
                   child: Icon(
                     Icons.edit,
                     size: 16,
                     color: Colors.white,
                   ),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
} 