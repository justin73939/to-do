import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ToDoList(),
      drawer: NavigationRailDrawer(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState()=>_ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<int> tasks = []; // Initial tasks, replace with your logic

  @override
  Widget build(BuildContext context) {
    return ListView(
            scrollDirection: Axis.vertical,
      children: [
        Wrap(
        spacing: 16.0, //Spacing between task squares
        children: [
          for (var taskNumber in tasks) TaskSquare(taskNumber: taskNumber),
          AddTaskSquare(onPressed: () {
            setState(() {
              tasks.add(tasks.length + 1);
           });
         }),
       ],
     ),
    ],
    );
  }
}

class TaskSquare extends StatelessWidget {
  final int taskNumber;

  TaskSquare({required this.taskNumber}); //this is a fucking parameter for a function wtf?

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(8),
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          // Navigate to a new screen when tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailsScreen(taskNumber: taskNumber)),
          );
        },
        child: Center(
          child: Text('Task $taskNumber'),
        ),
      ),
    );
  }
}

class AddTaskSquare extends StatelessWidget {
  final VoidCallback onPressed;

  AddTaskSquare({required this.onPressed}); //this is a paramater for calling the function, ni wtf

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(8),
      color: Colors.green,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Icon(Icons.add, size: 40, color: Colors.white),
        ),
      ),
    );
  }
}

class TaskDetailsScreen extends StatelessWidget {
  final int taskNumber;

  TaskDetailsScreen({required this.taskNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details - $taskNumber'),
      ),
      body: const Center(
        child: Text('Task Details Screen'),
      ),
    );
  }
}

class NavigationRailDrawer extends StatefulWidget {
  @override
  _NavigationRailDrawerState createState() => _NavigationRailDrawerState();
}

class _NavigationRailDrawerState extends State<NavigationRailDrawer> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    return NavigationRail(
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
        NavigationRailDestination(icon: Icon(Icons.account_circle), label: Text('Profile')),
        // Add more destinations as needed
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int index) {
        // Handle navigation based on the selected index
        setState(() {
          selectedIndex = index;
          switch (selectedIndex) {
      case 0:
        // Navigate to the Home screen
        page = Placeholder();
        break;
      case 1:
        // Navigate to the Settings screen
        page = Placeholder();
        break;
      // Add more cases for additional destinations
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
        });
      },
    );
  }
}