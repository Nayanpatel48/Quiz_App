import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Js/model/history_js_model.dart';
import 'package:repradar/Js/view/widget/question_card.dart';
import 'package:repradar/Js/viewmodel/js_view_model.dart';

class JsPage extends StatefulWidget {
  const JsPage({super.key});

  @override
  State<JsPage> createState() => _JsPageState();
}

class _JsPageState extends State<JsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JavaScript Test')),
      body: ChangeNotifierProvider(
        create: (context) {
          final vm = JsViewModel();

          vm.getJavaScriptQuestions();
          return vm;
        },

        //-----------
        child: Consumer<JsViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  if (vm.isLoading && vm.questionsList.isEmpty)
                    const LoadingIndicator(),

                  if (vm.questionsList.isEmpty)
                    Text('Questions list is empty!'),

                  Expanded(
                    child: ListView.builder(
                      // ESSENTIAL. Defines how many items the list should build.
                      itemCount: vm.questionsList.length,

                      // ESSENTIAL. Builds the widget for each index.
                      itemBuilder: (context, index) {
                        final questionsModel = vm.questionsList[index];

                        return QuestionCard(
                          // PASS THE PREVIOUSLY SAVED ANSWER
                          initialSelection: vm.getSelectedOption(
                            questionsModel.id,
                          ),

                          questionsModel: questionsModel,
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

                      //create history of JavaScript model
                      final model = HistoryJsModel(
                        testName: 'js_test',
                        testScore: vm.finalScore,
                      );

                      //post this to the server using viewmodel function
                      vm.storeHistoryOfJs(model);
                    },
                    child: Text('Submit the test'),
                  ),

                  vm.finalScore != null
                      ? Text('Test score is ${vm.finalScore}')
                      : Text('Test submission is pending!'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
