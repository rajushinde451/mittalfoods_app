import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'screens/workflow_entry_dialog.dart';
import 'package:mittalfoods_app/model/workflow_entry.dart';
import 'package:http/http.dart' as http;

class WorkflowView extends StatefulWidget {
  const WorkflowView({Key? key}) : super(key: key);

  @override
  State<WorkflowView> createState() => HomeViewWidgetState();
}

class HomeViewWidgetState extends State<WorkflowView> {
  //const HomeViewWidgetState({Key? key}) : super(key: key);
  late Future<List<WorkflowEntry>> workflowList2;

  @override
  void initState() {
    super.initState();
    workflowList2 = fetchWorkflows();
  }

  //ScrollController _listViewScrollController = new ScrollController();

  Future<List<WorkflowEntry>> fetchWorkflows() async {
    List<WorkflowEntry> workflowList = [];
    final response =
        await http.get(Uri.parse('https://mittalfoods.herokuapp.com/get_workflows'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> workflows = jsonDecode(response.body);

      for (var i = 0; i < workflows.length; i++) {
        Map<String, dynamic> workflow = workflows[i];
        workflowList.add(WorkflowEntry.fromJson(workflow));
      }

      return workflowList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: workflowList2,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              debugPrint("successfully connected");
              print(snapshot.data);
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data[index]));
              //return const Center(child: Text("successfully connected"));
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          },
        ),
//WorkflowEntry
        /* body: ListView.builder(
            itemCount: workflowList.length,
            itemBuilder: (BuildContext context, int index) =>
                buildTripCard(context, workflowList[index])),*/

        floatingActionButton: FloatingActionButton(
          onPressed: _openAddEntryDialog,
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ));
    // ignore: dead_code
  }

  Widget buildTripCard(BuildContext context, WorkflowEntry workflow) {
    //final workflow = workflowList[index];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      color: Colors.white60,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(children: <Widget>[
                Text(
                  "Wokflow:  " + workflow.id.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const Spacer(),
                Text(
                  "Shift:  " + workflow.shiftNumber.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const Spacer(),
                Text(
                  "Dryer:  " + workflow.dryer.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
              child: Row(children: <Widget>[
                const Spacer(),
                const Text("Operator: ", style: TextStyle(fontSize: 15.0)),
                Text(
                  workflow.operatorName,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Text("Start: ", style: TextStyle(fontSize: 15.0)),
                Text(
                  workflow.entryTime.hour.toString() +
                      ":" +
                      workflow.entryTime.minute.toString() +
                      ":" +
                      workflow.entryTime.second.toString(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                //Text(
                //   "${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}"),
                //const Spacer(),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  const Text("Entry: ", style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.entryTime.hour.toString() +
                        ":" +
                        workflow.entryTime.minute.toString() +
                        ":" +
                        workflow.entryTime.second.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(" Weight: ", style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.inWeight.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // const Icon(Icons.directions_car),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  const Text("Exit: ", style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.entryTime.hour.toString() +
                        ":" +
                        workflow.entryTime.minute.toString() +
                        ":" +
                        workflow.entryTime.second.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(" Weight: ", style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.outWeight.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // const Icon(Icons.directions_car),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  const Text("Trolley Count: ",
                      style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.trolleys.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text("Trey Count: ", style: TextStyle(fontSize: 15.0)),
                  Text(
                    workflow.treys.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // const Icon(Icons.directions_car),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Text('Trollies'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    //onPrimary: Colors.white,
                    side: const BorderSide(width: 1),
                    //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
                TextButton(
                  child: const Text('Add Trolley'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    //onPrimary: Colors.white,
                    side: const BorderSide(width: 1),
                    //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
                TextButton(
                  child: const Text('Start'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    //onPrimary: Colors.white,
                    side: const BorderSide(width: 1),
                    //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
                TextButton(
                  child: const Text('Complete'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    //onPrimary: Colors.white,
                    side: const BorderSide(width: 1),
                    //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddEntryDialog() async {
    WorkflowEntry? workflowNew =
        await Navigator.of(context).push(MaterialPageRoute<WorkflowEntry>(
            builder: (BuildContext context) {
              return const AddEntryDialog();
            },
            fullscreenDialog: true));
    if (workflowNew != null) {
      _addWorkflowSave(workflowNew);
      print(workflowNew.dryer);
    }
  }

  Future<void> _addWorkflowSave(WorkflowEntry wfEntry) async {
    //setState(() async {
    String query = "create_workflow?shift_number=" +
        wfEntry.shiftNumber.toString() +
        "&operator_name=" +
        wfEntry.operatorName;

    final response = await http.get(Uri.parse('https://mittalfoods.herokuapp.com/' + query));

    if (response.statusCode == 200) {
      print("Succeffully created new workflow");
      workflowList2 = fetchWorkflows();
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    //workflowList.add(wfEntry);

    //_listViewScrollController.animateTo(
    // workflowList.length * _itemExtent,
    // duration: const Duration(microseconds: 1),
    //  curve: new ElasticInCurve(0.01),
    //);
    //});
  }
}
