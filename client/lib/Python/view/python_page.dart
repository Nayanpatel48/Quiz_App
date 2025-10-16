import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Python/model/history_model.dart';
import 'package:repradar/Python/view/widget/questions_card.dart';
import 'package:repradar/Python/viewmodel/python_view_model.dart';

class PythonPage extends StatefulWidget {
  const PythonPage({super.key});

  @override
  State<PythonPage> createState() => _PythonPageState();
}

class _PythonPageState extends State<PythonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Python Test')),
      body: ChangeNotifierProvider(
        create: (context) {
          final vm = PythonViewModel();

          vm.getPythonQuestions();

          return vm;
        },

        child: Consumer<PythonViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  if (vm.isLoading && vm.questionsList.isEmpty)
                    const LoadingIndicator(),

                  if (vm.questionsList.isEmpty)
                    const Text('No questions found!'),

                  Expanded(
                    child: ListView.builder(
                      // ESSENTIAL. Defines how many items the list should build.
                      itemCount: vm.questionsList.length,

                      // ESSENTIAL. Builds the widget for each index.
                      itemBuilder: (context, index) {
                        final questionModel = vm.questionsList[index];

                        return QuestionsCard(
                          // PASS THE PREVIOUSLY SAVED ANSWER
                          initialSelection: vm.getSelectedOption(
                            questionModel.id,
                          ),

                          questionModel: questionModel,
                          onOptionSelected: (selectedAnswer) {
                            vm.recordAnswer(index, selectedAnswer!);
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      vm.calculateFinalScore();

                      final model = HistoryPythonModel(
                        testName: 'python_test',
                        testScore: vm.finalScore!,
                      );

                      vm.storeHistoryofPython(model);
                    },
                    child: Text('Submit the test'),
                  ),

                  vm.finalScore != null
                      ? Text('Your score is ${vm.finalScore}')
                      : Text('Text submission is pending!'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
