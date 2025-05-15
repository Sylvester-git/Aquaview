import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Icon(Icons.account_tree_sharp), Text('Dashboard')],
            ),
          ),
        ],
      ),
    );
  }
}
