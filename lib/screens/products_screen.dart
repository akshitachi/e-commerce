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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              title: "Eyevy",
              body: 'Full Rim Round, Cat-eyed Anti Glare Frame (48mm)',
              decoration: PageDecoration(
                bodyAlignment: Alignment.centerLeft,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
                imagePadding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                bodyTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
              ),
              image: _buildImage(
                'Rectangle',
              ),
            ),
            PageViewModel(
              title: "Eyevy",
              body: 'Full Rim Round, Cat-eyed Anti Glare Frame (48mm)',
              decoration: PageDecoration(
                bodyAlignment: Alignment.centerLeft,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
                imagePadding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                bodyTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
              ),
              image: _buildImage(
                'Rectangle',
              ),
            ),
            PageViewModel(
              title: "Eyevy",
              body: 'Full Rim Round, Cat-eyed Anti Glare Frame (48mm)',
              decoration: PageDecoration(
                bodyAlignment: Alignment.centerLeft,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
                imagePadding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                bodyTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
              ),
              image: _buildImage(
                'Rectangle',
              ),
            ),
            PageViewModel(
              title: "Eyevy",
              body: 'Full Rim Round, Cat-eyed Anti Glare Frame (48mm)',
              decoration: PageDecoration(
                bodyAlignment: Alignment.centerLeft,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
                imagePadding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                bodyTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xff707070),
                ),
              ),
              image: _buildImage(
                'Rectangle',
              ),
            ),
          ],
          onDone: () => {},
          showNextButton: false,
          showDoneButton: false,
          dotsFlex: 0,
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
