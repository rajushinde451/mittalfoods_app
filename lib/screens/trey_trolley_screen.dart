import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:mittalfoods_app/model/trey_or_trolley.dart';
import 'package:http/http.dart' as http;
import 'package:mittalfoods_app/screens/master_entry_dialog.dart';

class TreyOrTrolleyScreen extends StatefulWidget {
  final String pagetype;

  const TreyOrTrolleyScreen({Key? key, required this.pagetype})
      : super(key: key);

  @override
  State<TreyOrTrolleyScreen> createState() => TreyOrTrolleyWidgetState();
}

class TreyOrTrolleyWidgetState extends State<TreyOrTrolleyScreen> {
  //const HomeViewWidgetState({Key? key}) : super(key: key);
  late Future<List<TreyOrTrolly>> tratrollylist;

  @override
  void initState() {
    super.initState();
    tratrollylist = fetchtreytrolley();
  }

  //ScrollController _listViewScrollController = new ScrollController();

  Future<List<TreyOrTrolly>> fetchtreytrolley() async {
    List<TreyOrTrolly> tray_or_trolley_list = [];

    final response = await http.get(Uri.parse(
        'https://mittalfoods.herokuapp.com/master_get?type=' +
            widget.pagetype));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> master_data = jsonDecode(response.body);
      if (master_data.isNotEmpty) {
        for (var i = 0; i < master_data.length; i++) {
          Map<String, dynamic> master = master_data[i];
          tray_or_trolley_list.add(TreyOrTrolly.fromJson(master));
        }

        return tray_or_trolley_list;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data from API');
    }
    return tray_or_trolley_list;
  }

  @override
  Widget build(BuildContext context) {
    tratrollylist = fetchtreytrolley();
    return Scaffold(
        body: FutureBuilder(
          future: tratrollylist,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              debugPrint("successfully connected");
              print(snapshot.data);
              var data = snapshot.data;

              data ??= [];

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, data[index], widget.pagetype));
              //return const Center(child: Text("successfully connected"));
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _openAddEntryDialog,
          tooltip: 'Add Trey or Trolley',
          child: const Icon(Icons.add),
        ));
    // ignore: dead_code
  }

  Widget buildTripCard(
      BuildContext context, TreyOrTrolly tray_or_trolly, String pagetype) {
    //final workflow = workflowList[index];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      color: Colors.white60,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: Row(children: <Widget>[
                const Spacer(),
                pagetype == "TROLLEY"
                    ? const Icon(Icons.shopping_cart)
                    : const Icon(Icons.all_inbox),
                const Spacer(),
                Text(
                  //pagetype,
                  "ID:  " + tray_or_trolly.id.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const Spacer(),
                Text(
                  "Weight:  " + tray_or_trolly.weight.toString(),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const Spacer(),
                TextButton(
                  //child: const Text('Delete'),
                  child: const Icon(Icons.delete_sharp, color: Colors.red),
                  /*style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.white,
                    //onPrimary: Colors.white,
                    side: const BorderSide(width: 0),
                    //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),*/
                  onPressed: () {
                    print('Pressed');
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddEntryDialog() async {
    TreyOrTrolly? tra_trolley_new =
        await Navigator.of(context).push(MaterialPageRoute<TreyOrTrolly>(
            builder: (BuildContext context) {
              if (widget.pagetype == "TROLLEY") {
                return const TreyTrolleyProductEntryDialog(pageType: "TROLLEY");
              } else {
                return const TreyTrolleyProductEntryDialog(pageType: "TREY");
              }
            },
            fullscreenDialog: true));
    if (tra_trolley_new != null) {
      _addWorkflowSave(tra_trolley_new);
    }
  }

  Future<void> _addWorkflowSave(TreyOrTrolly tra_trolley_new) async {
    //setState(() async {
    String query = "master_create?type=" +
        widget.pagetype +
        "&id=" +
        tra_trolley_new.id.toString() +
        "&weight=" +
        tra_trolley_new.weight.toString();

    final response =
        await http.get(Uri.parse('https://mittalfoods.herokuapp.com/' + query));

    if (response.statusCode == 200) {
      print("Succeffully created new Trey or Trolley");
      tratrollylist = fetchtreytrolley();
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
