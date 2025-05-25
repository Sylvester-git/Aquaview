import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/features/dashboard/dashboard.dart';
import 'package:waterapp/util/color.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.onprimarydark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'AquaView',
            style: GoogleFonts.sora(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            thickness: 1,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashboardPage();
                        },
                      ),
                    );
                  },
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_balance_rounded, color: Colors.white),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashboardPage();
                        },
                      ),
                    );
                  },
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_balance_rounded, color: Colors.white),
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
        ],
      ),
    );
  }
}
