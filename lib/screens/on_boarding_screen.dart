import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Dio_and_Cashe/cache_helper.dart';
import 'login_screen.dart';

class BoardingModel {
  final String title1;
  final String title2;
  final String image;

  BoardingModel(
      {required this.title1, required this.title2, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      title1: 'OnBoard 1 Title',
      title2: 'OnBoard 1 Body',
      image: 'assets/images/3.jpg',
    ),
    BoardingModel(
      title1: 'OnBoard 2 Title',
      title2: 'OnBoard 2 Body',
      image: 'assets/images/2.jpg',
    ),
    BoardingModel(
      title1: 'OnBoard 3 Title',
      title2: 'OnBoard 3 Body',
      image: 'assets/images/1.jpg',
    ),
  ];
  var pageController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.savedata(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LogInScreeen()),
            (route) => false);
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text('Skip'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => pageView(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                    print('islast');
                  } else {
                    isLast = false;
                    print('notlast');
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 20),
                          curve: Curves.easeOutBack);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                  backgroundColor: Colors.blueAccent,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget pageView(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        Text(
          model.title1,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          model.title2,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
