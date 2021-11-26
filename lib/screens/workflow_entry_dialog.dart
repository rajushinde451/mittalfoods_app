import 'package:flutter/material.dart';

import '../model/workflow_entry.dart';

class AddEntryDialog extends StatefulWidget {
  const AddEntryDialog({Key? key}) : super(key: key);

  @override
  AddEntryDialogState createState() => AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  String? _operatorName;
  String? _shiftNumber;
  String? _dryerNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New workflow'),
          actions: [
            TextButton(
                onPressed: () {
                  //TODO: Handle save
                },
                child: const Text('SAVE')),
          ],
        ),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: DropdownButton<String>(
                value: _shiftNumber,
                isExpanded: true,
                hint: const Text('Select Shift'),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _shiftNumber = newValue!;
                  });
                },
                items: <String>['1', '2', '3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
              padding: const EdgeInsets.all(20),
              child: DropdownButton<String>(
                value: _operatorName,
                isExpanded: true,
                hint: const Text('Select Operator'),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _operatorName = newValue!;
                  });
                },
                items: <String>['Raj', 'Ravi', 'Vikas','Aks','Anaya']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
              padding: const EdgeInsets.all(20),
              child: DropdownButton<String>(
                value: _dryerNumber,
                isExpanded: true,
                hint: const Text('Select Dryer'),
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _dryerNumber = newValue!;
                  });
                },
                items: <String>['1', '2', '3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          TextButton(
            child: const Text('Create Workflow'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              //onPrimary: Colors.white,
              side: const BorderSide(width: 1),
              //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () {
              Navigator
                    .of(context)
                    .pop( WorkflowEntry(  //<--- Pass a value in Pop method
                      0, DateTime.now(), DateTime.now() , DateTime.now(), int.parse(_shiftNumber.toString()), _operatorName.toString(), "OPEN",  int.parse(_dryerNumber.toString()) ,0, 0, 0,0
                    ));
            },
          )
        ]));
    //);
  }
}
