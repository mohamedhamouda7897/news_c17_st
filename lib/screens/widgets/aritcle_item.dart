import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_st/models/news_response.dart';

class ArticleItem extends StatelessWidget {
  Articles article;

  ArticleItem({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child:
            CachedNetworkImage(
              imageUrl:article.urlToImage ?? "",
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
            ),

          ),
          Text(
            article.title ?? "",
            maxLines: 1,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          Text(
            article.description ?? "",
            maxLines: 2,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(article.author?.split(" ").first ?? ""),
              Text(article.publishedAt?.substring(0, 10) ?? ""),
            ],
          ),
        ],
      ),
    );
  }
}
