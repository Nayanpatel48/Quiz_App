import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
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

        //-------------
        child: Consumer<PythonViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  //---------------shows spinner/ loading indicator
                  if (vm.isLoading && vm.questionsList.isEmpty)
                    const LoadingIndicator(),

                  //----------------
                  if (vm.questionsList.isEmpty)
                    const Text('No questions found!'),

                  //------------------build scrollable list of question widgets
                  Expanded(
                    // We use Expanded here to ensure the ListView (which wants infinite height)
                    // gets a bounded space when placed inside a Column. If the ListView is the
                    // only widget in the body of a Scaffold, Expanded is not needed.
                    child: ListView.builder(
                      // ESSENTIAL. Defines how many items the list should build.
                      itemCount: vm.questionsList.length,

                      // ESSENTIAL. Builds the widget for each index.
                      itemBuilder: (context, index) {
                        final questionModel = vm.questionsList[index];

                        //------------use card here
                        return QuestionsCard(
                          // PASS THE PREVIOUSLY SAVED ANSWER
                          initialSelection: vm.getSelectedOption(
                            questionModel.id,
                          ),

                          questionModel: questionModel,
                          onOptionSelected: (selectedAnswer) {
                            // This callback gets the actual string of the selected option
                            print(
                              'Question ${questionModel.id}: User selected: $selectedAnswer',
                            );
                            print(vm.getUserAnswers());
                            vm.recordAnswer(index, selectedAnswer!);
                            // Here, you would typically update a map of user answers
                            // userAnswers[question.id] = selectedAnswer;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
