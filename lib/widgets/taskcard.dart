import 'package:flutter/material.dart';
import '../model/task.dart';

typedef void TaskChangedCallback(Task task, bool done);
typedef void TaskDeletedCallback(Task task);

class TaskCard extends StatelessWidget {
  TaskCard({
      @required this.task, @required this.onTaskChanged, @required this.onTaskDeleted
  }) : super(key: new ObjectKey(task));

  final Task task;
  final TaskChangedCallback onTaskChanged;
  final TaskDeletedCallback onTaskDeleted;

  @override
  Widget build(BuildContext context) {

    return new Dismissible(
      key: new Key(task.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (DismissDirection direction) {
        onTaskDeleted(task);
      },
      resizeDuration: null,
      background: new Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.blueGrey,
        child: new Row (
          children: <Widget>[
            new Icon(Icons.delete)
          ],
        ),
      ),
      child:new Card(
        child: new Padding (
          padding: const EdgeInsets.only(
            left: 14.0
          ),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(task.text)
              ),
              new Checkbox(
                value: task.done,
                onChanged: (bool val) {
                  onTaskChanged(task, val);
                }
              )
            ],
          )
        )
      )
    );
  }
}
