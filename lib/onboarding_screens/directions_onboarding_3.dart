import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class DirectionsOnboarding3 extends StatelessWidget {
  const DirectionsOnboarding3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: ClayContainer(
                borderRadius: 20,
                color: Colors.black,
                depth: 90,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/onboarding/directions.jpg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Follow ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.italic,
                  ),
                  children: [
                    TextSpan(
                      text: "Along The ",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: "Directions ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: "While Cooking",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
