import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:witt/witt.dart';

class DetailPage extends StatelessWidget {
  final int index;
  const DetailPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = WService.get<TodoController>();
    Todo todo = todos.todoList.value[index];
    final textController = TextEditingController(text: todo.name);
    DateTime todoTime = DateTime(2022);
    return Scaffold(
      appBar: AppBar(title: const Text("Detail")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimePickerSpinner(
              time: todo.time,
              is24HourMode: true,
              normalTextStyle: const TextStyle(fontSize: 20),
              spacing: 10,
              itemHeight: 40,
              isForce2Digits: true,
              onTimeChange: (time) {
                todoTime = time;
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: textController,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  todos.updateAt(index, textController.text, todoTime);
                },
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
