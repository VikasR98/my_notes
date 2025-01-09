import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingSliderUi extends StatelessWidget {
  const OnboardingSliderUi({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // margin: EdgeInsets.only(bottom: 30),
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView(
            // physics: BouncingScrollPhysics(),
            controller: _pageController,
            children: [
              Image.asset(
                diaryNew,
              ),
              Image.asset(welcomeImageTwo, ),
              Image.asset(welcomeImageThree, ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                strokeWidth: 10,
                radius: 20,
                offset: 0,

                activeDotColor: AppColors.primaryColor,
                dotColor: AppColors.lightModeSecondaryBgColor,
                expansionFactor: 4.0,
                // Adjust for a line-like effect
                dotHeight: 6,
                dotWidth: 20,
                // spacing: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
