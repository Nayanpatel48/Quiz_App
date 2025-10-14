import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Dart/model/history_dart_model.dart';
import 'package:repradar/Dart/view/widgets/question_card.dart';
import 'package:repradar/Dart/viewmodel/dart_view_model.dart';

class DartPage extends StatefulWidget {
  // constructor
  const DartPage({super.key});

  @override
  State<DartPage> createState() => _DartPageState();
}

class _DartPageState extends State<DartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Test')),
      body: ChangeNotifierProvider(
        create: (context) {
          final vm = DartViewModel();

          vm.getDartQuestions();

          return vm;
        },

        //--------
        child: Consumer<DartViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  //-----------showing loading indicator
                  if (vm.isLoading && vm.questions.isEmpty)
                    const LoadingIndicator(),

                  //-----------showing list is empty message
                  if (vm.questions.isEmpty)
                    const Text('Questions list is empty!'),

                  //------------
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.questions.length,
                      itemBuilder: (context, index) {
                        final questionModel = vm.questions[index];

                        //----------use the card here
                        return QuestionCard(
                          initialSelection: vm.getPreviouslySelectedAns(
                            questionModel.id,
                          ),

                          questionsModel: questionModel,
                          onOptionSelected: (selectedAnswer) {
                            // This callback gets the actual string of the selected option
                            vm.recordAnswer(index, selectedAnswer!);
                            // Here, you would typically update a map of user answers
                            // userAnswers[question.id] = selectedAnswer;
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vm.calculateFinalScore();

                      final model = HistoryDartModel(
                        testName: 'dart_test',
                        testScore: vm.finalScore!,
                      );

                      vm.storeHistoryOfDart(model);
                    },
                    child: Text('Submit test'),
                  ),

                  vm.finalScore != null
                      ? Text('Your final score is ${vm.finalScore}')
                      : Text('Test submission is pending.'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
