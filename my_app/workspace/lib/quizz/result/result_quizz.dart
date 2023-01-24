import 'package:flutter/material.dart';
import './todo.dart';
import './todo_item.dart';

class ResultQuizz extends StatefulWidget {
  final String? processName;
  const ResultQuizz({Key? key, required this.processName}) : super(key: key);

  @override
  State<ResultQuizz> createState() => _ResultQuizzState();
}

class _ResultQuizzState extends State<ResultQuizz> {
  late Future<List<ToDo>> futureToDoList;

  @override
  void initState() {
    super.initState();
    futureToDoList = ToDo.fetchTodoList(widget.processName);
  }

  @override
  Widget build(BuildContext context) {
    final processName = widget.processName;
    return 
        Scaffold(
        // backgroundColor: const Color.fromARGB(255, 233, 247, 233),
        body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos -' + processName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      FutureBuilder<List<ToDo>>(
                        future: futureToDoList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data == null) {
                              return const Text("No requirement to get this process");
                            }
                            for (var todoo in snapshot.data!) {
                              return  ToDoItem(
                                      todo: todoo,
                                      onToDoChanged: _handleToDoChange,
                                    );
                            }
                          } 
                            else if (snapshot.hasError) {
                            return
                              Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        }
                      )

                      
                      
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}

