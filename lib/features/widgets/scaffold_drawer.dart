import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/controllers/page_ctrl.dart';
import 'package:waterapp/features/cubit/current_page/current_page_cubit.dart';
import 'package:waterapp/util/color.dart';
import 'package:waterapp/util/enums.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final currenpagecubit = context.watch<CurrentPageCubit>();
    return Drawer(
      backgroundColor: AppColor.onprimarydark,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'AquaView',
                style: GoogleFonts.sora(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * .6,
                child: ListView(
                  children: [
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (currenpagecubit.state == CurrenPages.dashboard) {
                          scaffoldKey.currentState!.closeDrawer();
                        } else {
                          PageCtrl.changeCurrenPage(
                            context: context,
                            page: CurrenPages.dashboard,
                          );
                          scaffoldKey.currentState!.closeDrawer();
                        }
                      },
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_balance_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            'DashBoard',
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (currenpagecubit.state == CurrenPages.alerts) {
                          scaffoldKey.currentState!.closeDrawer();
                        } else {
                          PageCtrl.changeCurrenPage(
                            context: context,
                            page: CurrenPages.alerts,
                          );
                          scaffoldKey.currentState!.closeDrawer();
                        }
                      },
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.align_vertical_bottom_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            'Alerts',
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
