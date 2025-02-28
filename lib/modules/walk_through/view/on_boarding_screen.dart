import 'package:agent_app/modules/auth/view_model/auth_provider.dart';
import 'package:agent_app/res/contents/assets/constants.dart';
import 'package:agent_app/res/contents/texts.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

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

  /*  Positioned(
          bottom: 20.0,
          left: 20.0,
          right: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 42, height: 42),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onBoardingData.length,
                      (index) => buildIndicator(index),
                ),
              ),
              InkWell(
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
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: appColors.primaryDark,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(
                      currentPage != onBoardingData.length - 1
                          ? Icons.arrow_forward
                          : Icons.done,
                      color: appColors.appWhite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Image.asset(
          width: 500,
            ConstantImage.shape1,
                fit: BoxFit.fitWidth,
        ),

        // SizedBox(height: MediaQuery.of(context).size.height*0.80,
        //   width: MediaQuery.of(context).size.width,
        //   child: PageView.builder(
        //     itemCount: onBoardingData.length,
        //     scrollDirection: Axis.horizontal,
        //     controller: pageController,
        //     onPageChanged: onChanged,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Image.asset(
        //             width: 500,
        //             onBoardingData[index]['topImage']!,
        //
        //           ),
        //           const SizedBox(height: 1),
        //           ClipRRect(
        //             borderRadius: BorderRadius.circular(200),
        //             child: Image.asset(
        //               onBoardingData[index]['image']!,
        //               scale: 3,
        //             ),
        //           ),
        //           const SizedBox(height: 40),
        //           Text(
        //             onBoardingData[index]['title'] ?? "",
        //             style: context.textTheme.titleLarge,
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 20.0,
        //               vertical: 8,
        //             ),
        //             child: Text(
        //               onBoardingData[index]['description'] ?? "",
        //               style: context.textTheme.bodyLarge,
        //             ),
        //           ),
        //           const SizedBox(height: 20),
        //         ],
        //       );
        //     },
        //   ),
        // ),

      ],
    ),);
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
            currentPage == index ? appColors.appWhite : appColors.primaryDark,
      ),
    );
  }
}
