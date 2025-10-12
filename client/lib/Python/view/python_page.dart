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
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<PythonViewModel>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).getPythonQuestions(),
    );
  }

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
                  //---------------
                  if (vm.isLoading && vm.questionsList.isEmpty)
                    const LoadingIndicator(),

                  //----------------
                  if (vm.questionsList.isEmpty)
                    const Text('No questions found!'),

                  //------------------
                  ListView.builder(
                    // 1. IMPORTANT: Makes the ListView take only the height needed for its items.
                    shrinkWrap: true,

                    // 2. IMPORTANT: Disables the ListView's own scrolling, letting the outer
                    // SingleChildScrollView handle the scroll physics.
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.questionsList.length,
                    itemBuilder: (context, index) {
                      final question = vm.questionsList[index];

                      //------------use card here
                      return QuestionsCard(
                        question: question,
                        onOptionSelected: (selectedAnswer) {
                          // This callback gets the actual string of the selected option
                          print(
                            'Question ${question.id}: User selected: $selectedAnswer',
                          );
                          // Here, you would typically update a map of user answers
                          // userAnswers[question.id] = selectedAnswer;
                        },
                      );
                    },
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
