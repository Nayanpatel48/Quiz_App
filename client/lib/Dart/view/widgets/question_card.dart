import 'package:flutter/material.dart';
import 'package:repradar/Dart/model/dart_questions_model.dart';

class QuestionCard extends StatelessWidget {
  final DartQuestionsModel questionsModel;
  final String? initialSelection;
  final ValueChanged<String?>? onOptionSelected;

  const QuestionCard({
    required this.questionsModel,
    required this.initialSelection,
    this.onOptionSelected, //optional
    super.key,
  });

  List<String> getOptions() {
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...getOptions().map((optionText) {
              final isSelected = optionText == initialSelection;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  // 1. Style the button based on the saved state
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Colors.blueAccent
                        : Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {
                    // 2. Immediately tell the ViewModel the new choice
                    onOptionSelected!(optionText);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      optionText,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.blue.shade900
                            : Colors.black87,
                      ),
                    ),
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
