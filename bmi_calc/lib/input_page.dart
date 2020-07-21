import 'package:bmi_calc/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Gender_icon.dart';
import 'Cards.dart';
import 'brain.dart';
import 'constants.dart';

enum Gender {
  male,
  female,
}
Brain brain;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 175;
  int weight = 40, age = 12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w300),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Cards(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    cards: GenderIcon(
                      gender: "MALE",
                      icon: Icon(
                        FontAwesomeIcons.mars,
                        size: 80.0,
                      ),
                    ),
                    colors: selectedGender == Gender.male
                        ? kactiveCardcolor.withOpacity(0.5)
                        : kinactiveCardcolor,
                  ),
                ),
                Expanded(
                  child: Cards(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    cards: GenderIcon(
                      gender: "FEMALE",
                      icon: Icon(
                        FontAwesomeIcons.venus,
                        size: 80.0,
                      ),
                    ),
                    colors: selectedGender == Gender.female
                        ? kactiveCardcolor.withOpacity(0.5)
                        : kinactiveCardcolor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Cards(
              colors: kactiveCardcolor.withOpacity(0.5),
              cards: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "HEIGHT",
                    textAlign: TextAlign.center,
                    style: kLableTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "cm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                      overlayColor: Colors.black,
                      activeTrackColor: Colors.white,
                    ),
                    child: Slider(
                      onChanged: (input) {
                        setState(() {
                          height = input.round();
                        });
                      },
                      activeColor: Colors.white,
                      inactiveColor: Colors.blueAccent.withOpacity(0.7),
                      value: height.toDouble(),
                      min: 50,
                      max: 250,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Cards(
                    colors: kactiveCardcolor.withOpacity(0.5),
                    cards: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "WEIGHT",
                          style: kLableTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          weight.toString(),
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w100),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RoundButton(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            RoundButton(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Cards(
                    colors: kactiveCardcolor.withOpacity(0.5),
                    cards: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "AGE",
                          style: kLableTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          age.toString(),
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w100),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RoundButton(
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            RoundButton(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              brain = new Brain(height: height, weight: weight);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Result(
                    result: brain.getResult(),
                    ResultString: brain.getMessage(),
                    interP: brain.getResponse(),
                  ),
                ),
              );
            },
            child: Container(
              child: Center(
                  child: Text(
                "CALCULATE",
                style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              )),
              margin: EdgeInsets.all(20),
              height: 80.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.blue.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  RoundButton({@required this.child, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      shape: CircleBorder(),
      fillColor: kactiveCardcolor.withOpacity(0.5),
    );
  }
}
