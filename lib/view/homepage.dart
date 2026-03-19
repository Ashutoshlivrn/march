import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:march/cont/todo_controller.dart';
import 'package:march/repo/todo_repo.dart';
import 'package:march/view/to_do_screen.dart';


class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("FOR CALLING APIs"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () async{

            await ref.read(todoControllerProvider.notifier).getTodosFromHttp();
            if(context.mounted){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoScreen(),));
            }


          }, child: Text("for http call")),

          const SizedBox(height: 50,),

          TextButton(onPressed: () async{

            await ref.read(todoControllerProvider.notifier).getTodosFromDio();
            if(context.mounted){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ToDoScreen(),));
            }


          }, child: Text("for dio call")),
        ],
      ),
    );
  }
}
