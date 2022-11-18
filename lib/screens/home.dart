import 'package:flutter/material.dart';
import 'package:todo_app/contstants/colors.dart';
import 'package:todo_app/widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdDBColor,
      appBar: _buildApp(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: tdDBColor
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                searchBox(),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: Text('All task', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),textAlign: TextAlign.left,),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 70),
                    children: [
                      for (ToDo todoo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(bottom: 20, right: 10, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Color.fromARGB(255, 226, 226, 226),
                        offset: Offset(0.0,0.0),
                        blurRadius: 5.0,
                        spreadRadius: 0.0)],
                        borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new task',
                        border: InputBorder.none
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 5 
                    ),
                    child: Text('+', style: TextStyle(fontSize: 30),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todoList.add(ToDo(id:DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
      .where((item) => item.todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase()))
      .toList();
    }
    
    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: tdBlack, size: 20,),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: tdGrey
                  )
                ),
              ),
            );
  }

  AppBar _buildApp() {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: tdDBColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30,),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpg')
              ),
          )
        ],
      ),
    );
  }
}