import 'package:flutter/material.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:todo_list/pages/detail_page.dart';
import 'package:todo_list/pages/widgets/add_dialog.dart';
import 'package:witt/witt.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = WService.get<TodoController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        child: WListener(
          notifier: todos.todoList,
          builder: (context) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: todos.todoList.value.length,
              itemBuilder: (context, index) {
                Todo todo = todos.todoList.value[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFededed),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20, decoration: (todo.isChecked) ? TextDecoration.lineThrough : TextDecoration.none),
                                  ),
                                  Text(
                                    "${todo.time.hour.toString().split('.').first.padLeft(2, "0")}:${todo.time.minute.toString().split('.').first.padLeft(2, "0")}",
                                    style: const TextStyle(fontSize: 12, color: Colors.black38),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    todos.check(index);
                                  },
                                  child: (todo.isChecked) ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    todos.deleteAt(index);
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddDialog();
            },
          );
        },
      ),
    );
  }
}
