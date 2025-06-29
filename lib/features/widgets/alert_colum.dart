import 'package:flutter/material.dart';
import 'package:waterapp/features/model/alerts.dart';
import 'package:waterapp/util/functions.dart';

class AlertColumn extends StatelessWidget {
  const AlertColumn({super.key, required this.alert, required this.timestamp});
  final Alerts alert;
  final String timestamp;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
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
            timestamp,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ),

        _alertList(
          alerts: alert.alerts.cast<String>(),
          context: context,
          timestamp: alert.timestamp,
        ),
      ],
    );
  }

  Widget _alertList({
    required List<String> alerts,
    required BuildContext context,
    required String timestamp,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(alerts.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    alerts[index],
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Text(
                  convertTimestamp(timestamps: timestamp),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            if (index != alerts.length - 1)
              const Divider(color: Colors.white24),
          ],
        );
      }),
    );
  }
}
