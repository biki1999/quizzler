import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questions = [
    Question('Parrot is a Bird.', true),
    Question('Crow\'s color is white.', false),
    Question('Jagannath Temple is in Puri.', true),
    Question('Earth is the third planet of our solar system.', true),
    Question('Mountain walks.', false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questions[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    print('_questionNumber---$_questionNumber');
    print('_questions.length---${_questions.length}');
    print(_questionNumber >= (_questions.length - 1));
    return _questionNumber >= (_questions.length - 1);
  }

  void reset() {
    _questionNumber = 0;
  }
}
