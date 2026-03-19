

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march/repo/todo_repo.dart';

import '../model/todo_model.dart';

class TodoState {
  final bool isLoading;
  final String? error;
  final List<TodoModel> todos;

  TodoState({
    this.isLoading = false,
    this.error,
    this.todos = const [],
  });

  TodoState copyWith({
    bool? isLoading,
    String? error,
    List<TodoModel>? todos,
  }) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      todos: todos ?? this.todos,
    );
  }
}


final todoControllerProvider = StateNotifierProvider<ToDoController, TodoState>( (ref) => ToDoController(ref), );



class ToDoController extends StateNotifier<TodoState> {
  final Ref ref;

  ToDoController(this.ref) : super(TodoState());

  Future<void> getTodosFromHttp() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response =
      await ref.read(todoRepoProvider).getTodosFromHttp();

      // ❌ OLD ISSUE:
      // direct map call without checking type
      // final list = response.map((e) => TodoModel.fromJson(e)).toList();

      // ✅ FIX: Check if response is List
      if (response is List) {
        final list = response
            .map((e) {
          // ✅ ensure each item is Map
          if (e is Map<String, dynamic>) {
            return TodoModel.fromJson(e);
          } else {
            throw Exception("Invalid item type");
          }
        })
            .toList();

        state = state.copyWith(
          todos: list,
          isLoading: false,
        );
      } else {
        // ❌ response was not List (maybe String from catch)
        throw Exception("Response is not a List");
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getTodosFromDio() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response =
      await ref.read(todoRepoProvider).getTodosFromDio();

      // ❌ SAME ISSUE HERE ALSO (no type check before map)

      // ✅ FIX
      if (response is List) {
        final list = response
            .map((e) {
          if (e is Map<String, dynamic>) {
            return TodoModel.fromJson(e);
          } else {
            throw Exception("Invalid item type");
          }
        })
            .toList();

        state = state.copyWith(
          todos: list,
          isLoading: false,
        );
      } else {
        throw Exception("Response is not a List");
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
















