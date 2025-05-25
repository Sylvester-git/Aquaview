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
                    style: GoogleFonts.sora(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
                              ? AppColor.red.withOpacity(.8)
                              : AppColor.green.withOpacity(.8),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Center(
                      child: Text(
                        (getPredictionstate.prediction.status),
                        style: GoogleFonts.sora(
                          fontSize: 12,
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
