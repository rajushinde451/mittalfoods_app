import 'package:flutter/material.dart';
import 'package:mittalfoods_app/model/product.dart';

import '../model/trey_or_trolley.dart';
import '../model/workflow_entry.dart';

class TreyTrolleyProductEntryDialog extends StatefulWidget {
  final String pageType;
  const TreyTrolleyProductEntryDialog({Key? key, required this.pageType})
      : super(key: key);

  @override
  TreyTrolleyProductEntryDialogState createState() =>
      TreyTrolleyProductEntryDialogState();
}

class TreyTrolleyProductEntryDialogState
    extends State<TreyTrolleyProductEntryDialog> {
  int? _idnumber;
  double? _weight;
  String? _productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: widget.pageType == "TROLLEY"
                ? const Text('New Trolley')
                : widget.pageType == "TREY"
                    ? const Text('New Tray')
                    : const Text('New Product')),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter id',
              ),
              keyboardType: TextInputType.number,
              onChanged: _onChangedId,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.pageType == "PRODUCT"
                      ? 'Enter Product Name'
                      : 'Enter Weight'),
              keyboardType: widget.pageType == "PRODUCT"
                  ? TextInputType.text
                  : TextInputType.number,
              onChanged: _onChangedWeightProduct,
            ),
          ),
          TextButton(
            child: const Text('Create'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
              //onPrimary: Colors.white,
              side: const BorderSide(width: 1),
              //shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () {
              Navigator.of(context).pop(widget.pageType == "PRODUCT"
                  ? Product(_idnumber!, _productName!)
                  : TreyOrTrolly(_idnumber!, _weight!));
            },
          )
        ]));
    //);
  }

  void _onChangedWeightProduct(String value) {
    widget.pageType == "PRODUCT"
        ? _productName = value
        : _weight = double.parse(value);
  }

    void _onChangedId(String value) {
     _idnumber = int.parse(value);
  }
}
