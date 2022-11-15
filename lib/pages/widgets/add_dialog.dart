import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:witt/witt.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    DateTime todoTime = DateTime(2022);
    final todoCont = WService.get<TodoController>();
    return AlertDialog(
      title: const Text("Create Todo"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TimePickerSpinner(
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
            controller: textController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            todoCont.addTodo(textController.text, todoTime);
          },
          child: const Text("Create"),
        ),
      ],
    );
  }
}
