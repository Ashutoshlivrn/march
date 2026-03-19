import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cont/todo_controller.dart';

class ToDoScreen extends ConsumerStatefulWidget {
  const ToDoScreen({super.key});

  @override
  ConsumerState<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends ConsumerState<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoControllerProvider);
    return Scaffold(

      body: state.isLoading
          ? Center(child: CircularProgressIndicator(),)
          : state.error != null ? Center(child: Text(state.error!),)
          : Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text( state.todos[index].title)
                      );
                    },  ),
                ),

                Expanded(child: GridView.builder(
                    itemCount: state.todos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Text(state.todos[index].title);
                    },)
                )
              ],
      ),
    );
  }
}
