import 'package:flutter/material.dart';
import 'package:mittalfoods_app/model/product.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mittalfoods_app/screens/master_entry_dialog.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => ProductWidgetState();
}

class ProductWidgetState extends State<ProductScreen> {
  //const HomeViewWidgetState({Key? key}) : super(key: key);
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList = fetchproducts();
  }

  //ScrollController _listViewScrollController = new ScrollController();

  Future<List<Product>> fetchproducts() async {
    List<Product> productList = [];

    final response = await http.get(
        Uri.parse('https://mittalfoods.herokuapp.com/master_get?type=PRODUCT'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> productdata = jsonDecode(response.body);
      if (productdata.isNotEmpty) {
        for (var i = 0; i < productdata.length; i++) {
          Map<String, dynamic> product = productdata[i];
          productList.add(Product.fromJson(product));
        }

        return productList;
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data from API');
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    productList = fetchproducts();
    return Scaffold(
        body: FutureBuilder(
          future: productList,
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
                      buildTripCard(context, data[index]));
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

  Widget buildTripCard(BuildContext context, Product product) {
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
                const Icon( Icons.food_bank),
                const Spacer(),
                Text(
                  //pagetype,
                  "ID:  " + product.id.toStringAsFixed(0),
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const Spacer(),
                Text(
                  "Name:  " + product.name,
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
    Product? product_new =
        await Navigator.of(context).push(MaterialPageRoute<Product>(
            builder: (BuildContext context) {
              return const TreyTrolleyProductEntryDialog(pageType: "PRODUCT");
            },
            fullscreenDialog: true));
    if (product_new != null) {
      _addWorkflowSave(product_new);
    }
  }

  Future<void> _addWorkflowSave(Product product_new) async {
    //setState(() async {
    String query = "master_create?type=PRODUCT&id" +
        product_new.id.toString() +
        "&productname=" +
        product_new.name;

    final response =
        await http.get(Uri.parse('https://mittalfoods.herokuapp.com/' + query));

    if (response.statusCode == 200) {
      print("Succeffully created new product");
      productList = fetchproducts();
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
