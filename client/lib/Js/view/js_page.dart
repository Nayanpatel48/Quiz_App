import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Js/model/history_js_model.dart';
import 'package:repradar/Js/view/widget/question_card.dart';
import 'package:repradar/Js/viewmodel/js_view_model.dart';

class JsPage extends StatefulWidget {
  //constructor of this class
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
                  //-------------show loading indicator
                  if (vm.isLoading && vm.questionsList.isEmpty)
                    const LoadingIndicator(),

                  //-------------
                  if (vm.questionsList.isEmpty)
                    Text('Questions list is empty!'),

                  //-------------build scrollable list of questions
                  Expanded(
                    // We use Expanded here to ensure the ListView (which wants infinite height)
                    // gets a bounded space when placed inside a Column. If the ListView is the
                    // only widget in the body of a Scaffold, Expanded is not needed.
                    child: ListView.builder(
                      // ESSENTIAL. Defines how many items the list should build.
                      itemCount: vm.questionsList.length,

                      // ESSENTIAL. Builds the widget for each index.
                      itemBuilder: (context, index) {
                        final questionsModel = vm.questionsList[index];

                        //------------use card here
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
