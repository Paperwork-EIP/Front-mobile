import 'package:flutter/material.dart';
import 'package:my_app/home/home.dart';
import './todo.dart';
import './todo_item.dart';

class UserProcess extends StatefulWidget {
  final String? processName;
  const UserProcess({Key? key, required this.processName}) : super(key: key);

  @override
  State<UserProcess> createState() => _UserProcessState();
}

class _UserProcessState extends State<UserProcess> {
  late Future<List<ToDo>> futureToDoList;
  // var step = {'step_id': 'tom', 'is_done': 'pass@123'};
  List<Map> stepUpdate =
      []; // remetre la liste à null une fois le call effectuer

  @override
  void initState() {
    super.initState();
    futureToDoList = ToDo.fetchTodoList(widget.processName);
  }

  @override
  Widget build(BuildContext context) {
    final processName = widget.processName;
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Process"),
          backgroundColor: const Color.fromARGB(255, 96, 128, 118),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'All ToDos - ' + processName!,
                          style: const TextStyle(
                            // color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Tooltip(
                          message: 'See more details',
                          child: IconButton(
                            iconSize: 20,
                            icon: const Icon(
                              Icons.link,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<ToDo>>(
                        future: futureToDoList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No requirement to get this process",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 98, 153, 141),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ToDoItem(
                                    todo: snapshot.data![index],
                                    onToDoChanged: _handleToDoChange,
                                  );
                                },
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        }),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 40),
                      backgroundColor: const Color(0xFFFC6976),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      ToDo.fetchUpdateData(widget.processName, stepUpdate);
                      stepUpdate.clear();
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _handleToDoChange(ToDo todo) {
    Map details = <String, dynamic>{};
    setState(() {
      todo.isDone = !todo.isDone;
    });
    details['step_id'] = todo.id;
    details['response'] = todo.isDone;
    stepUpdate.add(details);
    print(stepUpdate);
  }
}
