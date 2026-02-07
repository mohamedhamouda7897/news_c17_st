import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_st/models/category_model.dart';

class CategoriesView extends StatelessWidget {
  Function onCategoryClicked;

  CategoriesView({super.key, required this.onCategoryClicked});

  var categories = CategoryModel.getCategoriesList();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning\nHere is Some News For You",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 18),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onCategoryClicked(categories[index]);
                  },
                  child: Stack(
                    alignment: index.isOdd
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(categories[index].image),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: index.isOdd ? 0 : 12,
                          right: index.isEven ? 0 : 12,
                        ),

                        margin: EdgeInsets.only(
                          bottom: 24,
                          left: index.isOdd ? 12 : 0,
                          right: index.isEven ? 12 : 0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: index.isOdd,
                              child: Image.asset(
                                "assets/images/arrow_back.png",
                              ),
                            ),
                            Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Visibility(
                              visible: index.isEven,
                              child: Image.asset("assets/images/arrow.png"),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 120,
                        left: index.isOdd ? 35 : null,
                        right: index.isOdd ? null : 35,

                        child: Text(
                          categories[index].label,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ],
        ),
      ),
    );
  }
}
