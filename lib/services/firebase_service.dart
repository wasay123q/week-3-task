import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tasks';

  // Get all tasks
  Stream<List<Task>> getTasks() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final tasks = snapshot.docs.map((doc) {
        return Task.fromMap(doc.id, doc.data());
      }).toList();
      print('Retrieved ${tasks.length} tasks from Firebase');
      return tasks;
    });
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    await _firestore.collection(_collection).add(task.toMap());
  }

  // Update a task
  Future<void> updateTask(Task task) async {
    await _firestore
        .collection(_collection)
        .doc(task.id)
        .update(task.toMap());
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      // First, verify the task exists
      final docSnapshot = await _firestore.collection(_collection).doc(taskId).get();
      if (!docSnapshot.exists) {
        print('Task $taskId does not exist, skipping deletion');
        return;
      }
      
      print('Deleting task: $taskId');
      await _firestore.collection(_collection).doc(taskId).delete().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Delete operation timed out');
        },
      );
      
      // Verify deletion
      final verifySnapshot = await _firestore.collection(_collection).doc(taskId).get();
      if (verifySnapshot.exists) {
        throw Exception('Task still exists after deletion');
      }
      
      print('Task deleted successfully: $taskId');
    } catch (e) {
      print('Error deleting task $taskId: $e');
      rethrow;
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      completedAt: !task.isCompleted ? DateTime.now() : null,
    );
    await updateTask(updatedTask);
  }
} 