import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/onboarding/widgets/onboarding_slider.dart';
import 'package:my_notes/widgets/app_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingPageOneState();
}

class _OnboardingPageOneState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _texts = [
    onboardingOneText,
    onboardingTwoText,
    onboardingThreeText,
  ];

  final List<String> _subtexts = [
    onboardingOneSubtext,
    onboardingTwoSubtext,
    onboardingThreeSubtext,
  ];

  void _goToNextPage() {
    if (_currentPage < _texts.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToWelcomePage() {
    Navigator.pushReplacementNamed(context, welcomeRoute);
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final int newPage = _pageController.page?.round() ?? 0;

      if (_currentPage != newPage) {
        setState(() {
          _currentPage = newPage;
          log('new page: $_currentPage');
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          OnboardingSliderUi(pageController: _pageController),
          Container(
            // color: Colors.amber,
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    _texts[_currentPage],
                    key: ValueKey<int>(_currentPage),
                    // Key to identify text changes
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          // fontSize: 48,
                        ),
                  ),
                ),
                verticalSpace(10),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    _subtexts[_currentPage],
                    key: ValueKey<int>(_currentPage),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                // Spacer(),
                if (_currentPage == 2) ...[
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Align(
                      key: ValueKey<int>(_currentPage),
                      // Ensure this key changes
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 40,
                        child: AppButton(
                          onTap: _goToWelcomePage,
                          btnText: 'Let\'s go',
                        ),
                      ),
                    ),
                  ),
                ],
                if (_currentPage < 2) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            _texts.length - 1, // Index of the last page
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          skipString,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: AppButton(
                          onTap: _goToNextPage,
                          btnText: nextString,
                        ),
                      ),
                    ],
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
