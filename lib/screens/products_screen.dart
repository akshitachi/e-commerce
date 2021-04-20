import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        'assets/user/$assetName.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          globalFooter: SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: FlatButton(
                      height: 60,
                      color: Colors.white,
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: FlatButton(
                      height: 60,
                      color: Color(0xffF3AA4E),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          key: introKey,
          pages: [
            PageViewModel(
              title: "",
              body: '',
              image: _buildImage(
                'Rectangle',
              ),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              image: _buildImage('Rectangle'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              image: _buildImage('Rectangle'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              image: _buildImage('Rectangle'),
              decoration: pageDecoration,
            ),
          ],

          onDone: () => {},
          showNextButton: false,
          showDoneButton: false,
          skipFlex: 8,
          nextFlex: 15,

          // skip: const Text('Skip'),
          done: const Icon(
            Icons.arrow_forward,
            color: Colors.grey,
          ),
          // onSkip: () {},
          // showSkipButton: true,
          dotsFlex: 0,

          next: const Icon(Icons.arrow_forward),
          dotsDecorator: DotsDecorator(
            size: Size(7.0, 8.0),
            color: Color(0xFFBDBDBD),
            activeColor: Colors.grey,
            activeSize: Size(22.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
