import 'package:flutter/material.dart';
import 'package:repradar/Js/model/js_questions_model.dart';

class QuestionCard extends StatelessWidget {
  final JsQuestionsModel questionsModel;
  final String? initialSelection;
  final ValueChanged<String?>? onOptionSelected;

  const QuestionCard({
    super.key,
    required this.questionsModel,
    required this.initialSelection,
    this.onOptionSelected,
  });

  List<String> getAlloptions() {
    return [
      questionsModel.optionA,
      questionsModel.optionB,
      questionsModel.optionC,
      questionsModel.optionD,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              questionsModel.question,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 12),

            //----------
            ...getAlloptions().map((optionText) {
              final isSelected = optionText == initialSelection;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  //1. give the color of the button based on saved state
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Colors.lightBlueAccent
                        : Colors.white,
                    elevation: 0,
                  ),

                  onPressed: () {
                    //2. as user choses the option immediately tell the viewmodel
                    onOptionSelected!(optionText);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(optionText),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
