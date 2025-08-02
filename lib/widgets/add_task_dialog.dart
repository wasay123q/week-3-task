import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/firebase_service.dart';

class AddTaskDialog extends StatefulWidget {
  final Task? task;

  const AddTaskDialog({super.key, this.task});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _firebaseService = FirebaseService();
  bool _isLoading = false;
  bool _isHighPriority = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _isHighPriority = widget.task!.isHighPriority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    isEditing ? Icons.edit : Icons.add_task,
                    color: const Color(0xFF6750A4),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEditing ? 'Edit Task' : 'Add New Task',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6750A4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'Enter task title',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF6750A4),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
                             // Description field
               TextFormField(
                 controller: _descriptionController,
                 maxLines: 3,
                 decoration: InputDecoration(
                   labelText: 'Description (Optional)',
                   hintText: 'Enter task description',
                   prefixIcon: const Icon(Icons.description),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                     borderSide: const BorderSide(
                       color: Color(0xFF6750A4),
                       width: 2,
                     ),
                   ),
                 ),
               ),
               const SizedBox(height: 16),
               
               // Priority checkbox
               Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   border: Border.all(
                     color: const Color(0xFF6750A4).withOpacity(0.3),
                   ),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Row(
                   children: [
                     Checkbox(
                       value: _isHighPriority,
                       onChanged: (value) {
                         setState(() {
                           _isHighPriority = value ?? false;
                         });
                       },
                       activeColor: const Color(0xFF6750A4),
                     ),
                     const SizedBox(width: 8),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Icon(
                                 Icons.priority_high,
                                 color: _isHighPriority ? Colors.red : Colors.grey,
                                 size: 20,
                               ),
                               const SizedBox(width: 8),
                               Text(
                                 'High Priority',
                                 style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600,
                                   color: _isHighPriority 
                                       ? Colors.red 
                                       : Colors.grey[600],
                                 ),
                               ),
                             ],
                           ),
                           if (_isHighPriority) ...[
                             const SizedBox(height: 4),
                             Text(
                               'This task will be marked as high priority',
                               style: TextStyle(
                                 fontSize: 12,
                                 color: Colors.grey[600],
                               ),
                             ),
                           ],
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
              const SizedBox(height: 24),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6750A4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            isEditing ? 'Update' : 'Add Task',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      if (widget.task != null) {
        // Update existing task
        final updatedTask = widget.task!.copyWith(
          title: title,
          description: description,
          isHighPriority: _isHighPriority,
        );
        await _firebaseService.updateTask(updatedTask);
      } else {
        // Create new task
        final newTask = Task(
          id: '',
          title: title,
          description: description,
          isHighPriority: _isHighPriority,
          createdAt: DateTime.now(),
        );
        await _firebaseService.addTask(newTask);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.task != null
                  ? 'Task updated successfully!'
                  : 'Task added successfully!',
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
} 