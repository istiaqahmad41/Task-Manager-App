import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTiles extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?deleteFunction;

  TodoTiles(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        
        endActionPane: ActionPane(

            motion:StretchMotion(), children: [


          SlidableAction(

            borderRadius: BorderRadius.circular(12),
            onPressed: deleteFunction,icon: Icons.delete,backgroundColor: Colors.red,)
        ]),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.lime, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Expanded(
                // This will ensure the text can wrap to multiple lines
                child: Text(
                  taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                  overflow: TextOverflow.visible, // Ensures text is visible
                  softWrap: true, // Ensures text will wrap to the next line
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
