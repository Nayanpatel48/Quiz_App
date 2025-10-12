import 'package:flutter/material.dart';
import 'package:repradar/Python/model/python_questions_model.dart';

// we'll use enum for giving name to small set of options of a question
enum QuestionOptions { optionA, optionB, optionC, optionD }

class QuestionsCard extends StatefulWidget {
  final PythonQuestionsModel question;
  final ValueChanged<String?>? onOptionSelected;
  //call back when an option is selected

  //constructor of this widget
  const QuestionsCard({
    required this.question,
    this.onOptionSelected, //call back is optional
    super.key,
  });

  @override
  State<QuestionsCard> createState() => _QuestionsCardState();
}

class _QuestionsCardState extends State<QuestionsCard> {
  //store the currently selected option for this question
  QuestionOptions? _selectedOption;

  //Helper to map the enum to the actual option string from the model
  String? _getOptionString(QuestionOptions? option) {
    if (option == null) {
      return null;
    }

    //--------
    final options = {
      QuestionOptions.optionA: widget.question.optionA,
      QuestionOptions.optionB: widget.question.optionB,
      QuestionOptions.optionC: widget.question.optionC,
      QuestionOptions.optionD: widget.question.optionD,
    };

    return options[option];
  }

  @override
  Widget build(BuildContext context) {
    //List all the options to generate radio options easily
    final List<String> options = [
      widget.question.optionA,
      widget.question.optionB,
      widget.question.optionC,
      widget.question.optionD,
    ];

    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //------------Question text
            Text(
              'Q${widget.question.id} : ${widget.question.question}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            //-------------
            const SizedBox(height: 16),

            //-------------Radio buttons for options
            ...options.map((optionText) {
              QuestionOptions? currentOptimumEnum;

              if (optionText == widget.question.optionA) {
                currentOptimumEnum = QuestionOptions.optionA;
              }
              if (optionText == widget.question.optionB) {
                currentOptimumEnum = QuestionOptions.optionB;
              }
              if (optionText == widget.question.optionC) {
                currentOptimumEnum = QuestionOptions.optionC;
              }
              if (optionText == widget.question.optionD) {
                currentOptimumEnum = QuestionOptions.optionD;
              }

              //-------------
              return RadioListTile<QuestionOptions>(
                title: Text(optionText),
                value: currentOptimumEnum!,
                groupValue: _selectedOption,
                onChanged: (QuestionOptions? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });

                  //call the callback function if provided
                  widget.onOptionSelected?.call(_getOptionString(newValue));
                },
                dense: true,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
