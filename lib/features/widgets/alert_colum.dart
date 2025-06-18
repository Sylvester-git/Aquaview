import 'package:flutter/material.dart';
import 'package:waterapp/features/model/alerts.dart';
import 'package:waterapp/util/functions.dart';

class AlertColumn extends StatelessWidget {
  const AlertColumn({super.key, required this.alert});
  final Alerts alert;

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
            convertTimestamp(timestamps: alert.timestamp),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ),

        _alertList(alerts: alert.alerts.cast<String>(), context: context),
      ],
    );
  }

  Widget _alertList({
    required List<String> alerts,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(alerts.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alerts[index],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            if (index != alerts.length - 1)
              const Divider(color: Colors.white24),
          ],
        );
      }),
    );
  }
}
