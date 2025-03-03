import 'package:agent_app/modules/auth/view_model/auth_provider.dart';
import 'package:agent_app/res/contents/assets/constants.dart';
import 'package:agent_app/res/contents/texts.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  int currentPage = 0;

  List<Map<String, String>> onBoardingData = [
    {
      'topImage': ConstantImage.shape1,
      'image': ConstantImage.purchaseOnline,
      'title': texts.w1Title,
      'description': texts.w1Des,
    },
    {
      'topImage': ConstantImage.shape2,
      'image': ConstantImage.trackOrder,
      'title': texts.w2Title,
      'description': texts.w2Des,
    },
    {
      'topImage': ConstantImage.shape3,
      'image': ConstantImage.getOrder,
      'title': texts.w3Title,
      'description': texts.w3Des,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: onBoardingData.length,
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: onChanged,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Image.asset(
                      width: MediaQuery.of(context).size.width,
                      onBoardingData[index]['topImage']!,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned(
                      top: 270,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            onBoardingData[index]['image']!,
                            scale: 1.8,
                          ),
                          const SizedBox(height: 25),
                          Center(
                            child: Text(
                              onBoardingData[index]['title'] ?? "",
                              textAlign: TextAlign.center,
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 8,
                            ),
                            child: Center(
                              child: Text(
                                onBoardingData[index]['description'] ?? "",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    ).setWalkThrough(context);
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: appColors.appBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        texts.skip,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: appColors.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onBoardingData.length,
                    (index) => buildIndicator(index),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (currentPage != onBoardingData.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).setWalkThrough(context);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: appColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        currentPage != onBoardingData.length - 1
                            ? texts.next
                            : texts.done,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: appColors.appWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            currentPage == index
                ? appColors.secondary
                : appColors.appBackground,
      ),
    );
  }
}
