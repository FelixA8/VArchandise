import 'package:flutter/material.dart';
import 'package:varchandise/widgets/history_listview.dart';

class HistorySection extends StatefulWidget {
  const HistorySection({super.key});

  @override
  State<HistorySection> createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          HistoryListView()
        ],
      ),
    );
    ;
  }
}
