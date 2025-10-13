import 'package:flutter/material.dart';
import 'package:repradar/Python/model/python_questions_model.dart';

class QuestionsCard extends StatelessWidget {
  final PythonQuestionsModel questionModel;
  final String? initialSelection;
  final ValueChanged<String?>? onOptionSelected;
  //call back when an option is selected

  //constructor of this widget
  const QuestionsCard({
    required this.initialSelection,
    required this.questionModel,
    this.onOptionSelected, //call back is optional
    super.key,
  });

  //helper method for listing all the options for easier iteration
  List<String> get _options {
    return [
      questionModel.optionA,
      questionModel.optionB,
      questionModel.optionC,
      questionModel.optionD,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the question text
            Text(
              questionModel.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            //----------
            const SizedBox(height: 12),

            //---------iterate over all available options
            ..._options.map((optionText) {
              //check if this option matches the saved selection
              final isSelected = optionText == initialSelection;

              //-------
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  // 1. Style the button based on the saved state
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Colors.blue.shade100
                        : Colors.grey.shade100,
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
