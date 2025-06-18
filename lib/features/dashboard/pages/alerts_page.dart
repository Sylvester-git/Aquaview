import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/features/cubit/get_alerts/get_alerts_cubit.dart';
import 'package:waterapp/features/widgets/alert_colum.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAlertsCubit, GetAlertsState>(
      builder: (context, getAlertsstate) {
        if (getAlertsstate is GettingAlerts ||
            getAlertsstate is GetAlertsInitial) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (getAlertsstate is ErrorGettingAlerts) {
          return Center(
            child: Text(
              getAlertsstate.errormessage,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 18),
            ),
          );
        }
        if (getAlertsstate is GottenAlerts) {
          return getAlertsstate.alerts.isEmpty
              ? Center(
                child: Text(
                  'No available alerts',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
              : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  padding: EdgeInsets.only(
                    bottom: 30,
                    top: 20,
                    left: 16,
                    right: 16,
                  ),
                  itemCount: getAlertsstate.alerts.length,
                  itemBuilder: (context, index) {
                    return AlertColumn(alert: getAlertsstate.alerts[index]);
                  },
                ),
              );
        }
        return SizedBox();
      },
    );
  }
}
