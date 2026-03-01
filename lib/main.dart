import 'package:flutter/material.dart';
import 'data_warehouse.dart';

void main() => runApp(const MaterialApp(home: TaskScreen()));

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Map<String, dynamic>> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  Future<void> _refreshTasks() async {
    final data = await DatabaseOperator.getTasks();
    setState(() {
      _tasks = data;
      _isLoading = false;
    });
  }

  Future<void> _addTask() async {
    await DatabaseOperator.insertTask('Task #${_tasks.length + 1}');
    _refreshTasks();
  }

  Future<void> _deleteTask(int id) async {
    await DatabaseOperator.deleteTask(id);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced SQLite Web')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final item = _tasks[index];
                return ListTile(
                  title: Text(item['task_name']),
                  leading: CircleAvatar(child: Text('${item['id']}')),
                  // Added a delete button to each row
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(item['id']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
