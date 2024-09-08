import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
      home: Quizler(),
    ));

class Quizler extends StatefulWidget {
  const Quizler({super.key});

  @override
  State<Quizler> createState() => _QuizlerState();
}

class _QuizlerState extends State<Quizler> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
            size: 50.0, // Set the desired size
          ),
        );
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
          size: 50.0,
        ));
      }

      if (quizBrain.isFinished()) {
        _showMyDialog();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Finished!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have reached the end of the quiz.'),
                Text('Would you like to restart?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
            ),
          ],
        );
      },
    );
  }

  void resetQuiz() {
    setState(() {
      quizBrain.reset();
      scoreKeeper.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 34),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                    child: const Text(
                      'True',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      checkAnswer(false);
                    },
                    child: const Text(
                      'False',
                      style: TextStyle(color: Colors.white, fontSize: 30,),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60.0,
                child: Row(
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
