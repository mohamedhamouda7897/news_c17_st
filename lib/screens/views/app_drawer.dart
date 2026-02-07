import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_st/core/theme/bloc/cubit.dart';
import 'package:news_c17_st/core/theme/dark_theme.dart';
import 'package:news_c17_st/core/theme/light_theme.dart';

class AppDrawer extends StatelessWidget {
  Function onDrawerClicked;

  AppDrawer({super.key, required this.onDrawerClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .8,

      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: Center(
                child: Text(
                  "News App",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      onDrawerClicked();
                    },
                    child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "GO TO HOME",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Light Theme",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value:
                              ThemeCubit.get(context).baseColors is LightTheme,
                          onChanged: (value) {
                            ThemeCubit.get(context).changeTheme();
                            Navigator.pop(context);
                          },

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
