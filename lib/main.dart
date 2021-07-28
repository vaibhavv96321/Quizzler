import 'package:flutter/material.dart';
import 'quiz_Brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int count = 0;
  int len = quizBrain.length();
  List<Icon> scoreKeeper = [];

  // List<String> questions = [
  //   'You can lead a cow downstairs but not upstairs',
  //   'Approximatly one quater of the human bone are in the feet',
  //   'A Slug\'s blood is green',
  // ];
  // List<bool> correct = [
  //   false,
  //   true,
  //   true,
  // ];
  //Here i have created these lists of questions and answers seperatly but now i can make it simontainously with the help of the class
  //here i have made a different class for the things below to mak eit a bit less messy....

  // List<Question> q1 = [
  //   Question(q: 'You can lead a cow downstairs but not upstairs', a: false),
  //   Question(
  //       q: 'Approximatly one quater of the human bone are in the feet',
  //       a: true),
  //   Question(q: 'A Slug\'s blood is green', a: true),
  //   Question(q: 'Hey bros', a: true)
  // ];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        var alertStyle = AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: true,
          isOverlayTapDismiss: false,
          descStyle: TextStyle(fontWeight: FontWeight.bold),
          descTextAlign: TextAlign.start,
          animationDuration: Duration(milliseconds: 300),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.grey,
            ),
          ),
          titleStyle: TextStyle(
            color: Colors.red,
          ),
          alertAlignment: Alignment.center,
        );
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.info,
          title: "Congrats",
          desc:
              "You have successfully finished the Quiz with a Total score of $count out of $len",
          buttons: [
            DialogButton(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Icon(Icons.restart_alt_rounded),
              ]),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper.clear();
        count = 0;
      } else {
        if (userPickedAnswer == correctAnswer) {
          count++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RawMaterialButton(
              fillColor: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: RawMaterialButton(
              fillColor: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
