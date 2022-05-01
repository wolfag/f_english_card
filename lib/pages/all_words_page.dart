import 'package:auto_size_text/auto_size_text.dart';
import 'package:f_english_card/models/english_today.dart';
import 'package:f_english_card/values/app_colors.dart';
import 'package:f_english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class AllWordsPage extends StatelessWidget {
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  final List<EnglishToday> words;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.second,
      appBar: AppBar(
        backgroundColor: AppColors.second,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyles.h3.copyWith(
            color: AppColors.text,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: words
              .map(
                (e) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: AutoSizeText(
                    e.noun ?? '',
                    style: AppStyles.h3.copyWith(shadows: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(3, 6),
                        blurRadius: 6,
                      ),
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
