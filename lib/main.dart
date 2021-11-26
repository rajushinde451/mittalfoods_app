import 'package:flutter/material.dart';
import 'workflow_screen.dart';
import 'master_entry_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Master',
                ),
                Tab(
                  icon: Icon(Icons.work),
                  text: 'Workflow',
                ),
                Tab(
                  icon: Icon(Icons.storage),
                  text: 'Inventory',
                ),
              ],
            ),
            title: const Text('Mittal Foods'),
          ),
          body: const TabBarView(
            children: [
              WorkflowView(),
              MasterEntryScreen(),
              WorkflowView(),
              WorkflowView(),
            ],
          ),
        ),
      ),
    );
  }
}
