import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
import 'package:f_english_card/models/english_today.dart';
import 'package:f_english_card/pages/all_words_page.dart';
import 'package:f_english_card/pages/control_page.dart';
import 'package:f_english_card/values/app_colors.dart';
import 'package:f_english_card/values/app_styles.dart';
import 'package:f_english_card/values/share_keys.dart';
import 'package:f_english_card/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int count = preferences.getInt(ShareKeys.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: count, max: nouns.length);

    rans.forEach((item) {
      newList.add(nouns[item]);
    });

    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.second,
      appBar: AppBar(
        actions: [],
        title: Text(
          'English today',
          style: AppStyles.h4.copyWith(
            color: AppColors.text,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.second,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'It is amazing how complete is the decision that beauty is goodness.',
                style: AppStyles.h5.copyWith(
                  fontSize: 12,
                  color: AppColors.text,
                ),
              ),
            ),
            Container(
              height: size.height * 2 / 3,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  String firstLetter = words[index].noun?.substring(0, 1) ?? '';
                  String remainLetter = words[index].noun?.substring(1) ?? '';

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: firstLetter,
                              style: AppStyles.h3.copyWith(
                                fontSize: 89,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(3, 6),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              children: [
                                TextSpan(
                                  text: remainLetter,
                                  style: AppStyles.h3.copyWith(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    shadows: const [
                                      BoxShadow(
                                        color: Colors.black38,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: AutoSizeText(
                              'Think of all the beauty still left around you and be happy.',
                              style: AppStyles.h4.copyWith(
                                letterSpacing: 1,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: words.length,
              ),
            ),
            _currentIndex >= 0
                ? buildShowMore()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      height: 8,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildIndicator(index == _currentIndex, size);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getEnglishToday();
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text(
                  'You mind',
                  style: AppStyles.h3.copyWith(
                    color: AppColors.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                  label: 'Favorite',
                  onTap: () {
                    print('ok');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                  label: 'Your control',
                  onTap: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ControlPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      height: 8,
      curve: Curves.bounceInOut,
      width: isActive ? size.width * 1 / 5 : 24,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(2, 3),
            blurRadius: 3,
          )
        ],
      ),
    );
  }

  Widget buildShowMore() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Material(
        color: AppColors.primary,
        elevation: 4,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AllWordsPage(words: words),
              ),
            );
          },
          splashColor: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              'Show more',
              style: AppStyles.h5,
            ),
          ),
        ),
      ),
    );
  }
}
