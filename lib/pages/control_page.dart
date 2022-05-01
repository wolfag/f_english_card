import 'package:f_english_card/values/app_colors.dart';
import 'package:f_english_card/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initDefaultCounter();
  }

  initDefaultCounter() async {
    preferences = await SharedPreferences.getInstance();
    int count = await preferences.getInt(ShareKeys.counter) ?? 5;

    setState(() {
      sliderValue = count.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.second,
      appBar: AppBar(
        actions: [],
        title: Text(
          'Your control',
          style: AppStyles.h4.copyWith(
            color: AppColors.text,
            fontSize: 36,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            await preferences.setInt(ShareKeys.counter, sliderValue.toInt());

            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
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
            Spacer(),
            Text(
              'How much a number word at once?',
              style: AppStyles.h4.copyWith(
                color: AppColors.lightGrey,
                fontSize: 18,
              ),
            ),
            Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                color: AppColors.primary,
                fontSize: 150,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Slider(
              value: sliderValue,
              divisions: 95,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.primary,
              onChanged: (val) {
                setState(() {
                  sliderValue = val;
                });
              },
              min: 5,
              max: 100,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text(
                'slide to set',
                style: AppStyles.h5.copyWith(
                  color: AppColors.text,
                ),
              ),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
