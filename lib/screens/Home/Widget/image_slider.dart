import 'dart:async';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final Function(int) onChange;
  final int currentSlide;

  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });
  @override
  _ImageSliderState createState() => _ImageSliderState();
}


class _ImageSliderState extends State<ImageSlider>{
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  @override

   void initState (){super.initState();
    _pageController = PageController(initialPage: widget.currentSlide);


    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer){
      if(_currentPage < 2){
        _currentPage++;
      }else  {
        _currentPage = 0;
      }
      _pageController.animateToPage
        (_currentPage, duration: Duration(milliseconds: 3000),
          curve: Curves.easeInOut,);
    });

  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height:
          220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged:(index){
                setState(() {
                  _currentPage = index;
                });
                widget.onChange(index);
              },



              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "images/slider.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/image1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/slider3.png",
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds:
                  1000),
                  width: widget.currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.currentSlide == index
                          ? Colors.deepOrangeAccent
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
}
