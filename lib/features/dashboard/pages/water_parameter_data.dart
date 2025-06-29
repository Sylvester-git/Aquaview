import 'package:flutter/material.dart';
import 'package:waterapp/features/model/wqms.dart';

import '../../../util/functions.dart';

class WaterParameterDataPage extends StatelessWidget {
  const WaterParameterDataPage({
    super.key,
    required this.parameterName,
    required this.waterparametrModel,
  });

  final String parameterName;
  final List<WQMSModel> waterparametrModel;

  @override
  Widget build(BuildContext context) {
    final groupedItems = groupWQMSByDay(
      waterparametrModel,
    ); // 'items' is your raw list
    final groupedKeys =
        groupedItems.keys.toList()
          ..sort((a, b) => b.compareTo(a)); // latest date first
    return Scaffold(
      appBar: AppBar(title: Text(parameterName)),
      body: ListView.separated(
        itemCount: groupedKeys.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        itemBuilder: (context, index) {
          final dateKey = groupedKeys[index];
          final readings = groupedItems[dateKey]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  dateKey,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                ),
              ),
              ...readings.map(
                (reading) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    // if (index != alerts.length - 1)
                    //   const Divider(color: Colors.white24),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
