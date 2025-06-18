import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/cubit/current_page/current_page_cubit.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/dashboard/pages/alerts_page.dart';
import 'package:waterapp/features/dashboard/pages/dashboard_page.dart';

import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/enums.dart';

class LoadedDashBoard extends StatelessWidget {
  const LoadedDashBoard({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final currenpagecubit = context.watch<CurrentPageCubit>();
    return Column(
      children: [
        Container(
          color: AppColor.onprimarydark,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                  Text(
                    currenpagecubit.state == CurrenPages.dashboard
                        ? 'Dashboard'
                        : "Alerts",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),

              BlocBuilder<GetPredictionCubit, GetPredictionState>(
                builder: (context, getPredictionstate) {
                  return Container(
                    padding: EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      color:
                          (getPredictionstate as GottenPrediction)
                                      .prediction
                                      .status
                                      .toLowerCase() ==
                                  'unsafe'
                              ? AppColor.red.withOpacity(.6)
                              : AppColor.green.withOpacity(.6),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        (getPredictionstate.prediction.status),
                        style: GoogleFonts.sora(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        currenpagecubit.state == CurrenPages.dashboard
            ? DashboardPage()
            : AlertsPage(),
      ],
    );
  }
}
