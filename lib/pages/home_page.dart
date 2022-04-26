import 'package:f_english_card/values/app_colors.dart';
import 'package:f_english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
          onTap: () {},
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
                              text: 'B',
                              style: AppStyles.h3.copyWith(
                                fontSize: 89,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(3, 6),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              children: [
                                TextSpan(
                                  text: 'eautiful',
                                  style: AppStyles.h3.copyWith(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
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
                            child: Text(
                              'Think of all the beauty still left around you and be happy.',
                              style: AppStyles.h4.copyWith(
                                letterSpacing: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
            Padding(
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
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      height: 8,
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
}
