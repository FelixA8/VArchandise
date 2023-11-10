import 'package:flutter/material.dart';
import 'package:varchandise/rest/get_history_api.dart';
import 'package:varchandise/rest/product_api.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            getSpecificProduct("PR001");
          },
          child: Text('Click Me!')),
    );
  }
}
