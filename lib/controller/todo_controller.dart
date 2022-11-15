import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:witt/witt.dart';

class TodoController {
  final todoList = ValueNotifier(<Todo>[]);

  void addTodo(text, time) {
    final context = WRouter.navigatorKey.currentContext!;
    Todo todo = Todo(name: text, isChecked: false, time: time);
    todoList.value = [...todoList.value, todo];
    Navigator.pop(context);
  }

  void check(index) {
    final newList = [...todoList.value];
    newList[index].isChecked = !newList[index].isChecked;

    todoList.value = newList;
  }

  void deleteAt(index) {
    todoList.value = [...todoList.value]..removeAt(index);
  }

  void updateAt(int index, text, time) {
    final context = WRouter.navigatorKey.currentContext!;
    Todo todo = Todo(name: text, isChecked: false, time: time);

    final newList = [...todoList.value];
    newList[index] = todo;

    todoList.value = newList;
    Navigator.pop(context);
  }
}
