import 'package:flutter/material.dart';
import './model/task.dart';
import './widgets/taskcard.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TODO App',
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new MyHomePage(title: 'TODO App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //dummy initial values
  List<Task> goals = [
    new Task(id: new DateTime.now().millisecondsSinceEpoch, text: "One", done: false),
    new Task(id: new DateTime.now().millisecondsSinceEpoch, text: "Two", done: false),
    new Task(id: new DateTime.now().millisecondsSinceEpoch, text: "Three", done: false)
  ];

  void _addItem() {

    final addItemController = new TextEditingController();

    Navigator.push(context, 
          new MaterialPageRoute(builder: (context) => 
            new Scaffold(
              appBar: new AppBar(
                title: new Text("Add new TODO"),
              ),
              body: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: new TextField(
                            controller: addItemController,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                            labelText: "What do I have to do?"
                          ),
                        ),
                    ),
                    new RaisedButton(
                      child: new Text('OK'),
                      color: Colors.blueGrey,
                      onPressed: () {
                        var text = addItemController.text;

                        if(text == ""){
                          var alert = new AlertDialog(
                            title: new Text("Come on..."),
                            content: new Text("Please enter something...")
                          );

                          showDialog(context: context, child: alert);
                          return;
                        }

                        _handleGoalAdded(text);

                        Navigator.pop(context);
                      }
                    )
                  ],
                )
              )
            )
          ),
        );
  }

  void _handleGoalChanged(Task g, bool done) {
    setState(() {
      g.done = done;
    });
  }

  void _handleGoalAdded(value){
    var generateId = new DateTime.now().millisecondsSinceEpoch;

    setState((){
      goals.add(new Task(id: generateId, text: value, done: false));
    });
  }

  void _handleGoalDeleted(item){
    setState((){
      goals.remove(item);
    });
  }

  Widget _drawList() {
    
    List<Widget> list = [];
    for(var goal in goals ){
      list.add(
        new TaskCard(
          task: goal,
          onTaskChanged: _handleGoalChanged,
          onTaskDeleted: _handleGoalDeleted,
        )
      );
    }

    return new ListView(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),

      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: _drawList(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add a new item',
        child: new Icon(Icons.add),
      ),
    );
  }
}
