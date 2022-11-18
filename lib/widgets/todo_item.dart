import 'package:flutter/material.dart';
import '../contstants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({Key? key, required this.todo, required this.onDeleteItem, required this.onToDoChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          //print('Click to item');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box : Icons.check_box_outline_blank, 
          color: tdBlue,),
        title: Text(todo.todoText!, style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone? TextDecoration.lineThrough : null
        ),),
        trailing: Container(
            width: 35,
            height: 35,
            child: IconButton(icon: Icon(Icons.delete), color: Color.fromARGB(255, 255, 110, 99), 
              onPressed: () { 
                //print('Click to delete button');
                onDeleteItem(todo.id);
              },
            ),
           ),
          ),
      );
    
  }
}