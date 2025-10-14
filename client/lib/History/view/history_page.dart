import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/History/viewmodel/history_view_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('History Page')),
      body: ChangeNotifierProvider(
        create: (context) {
          final vm = HistoryViewModel();

          vm.getHistoryOfUser();

          return vm;
        },

        child: Consumer<HistoryViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  //show the loading indiactor
                  if (vm.isLoading && vm.historyObjects.isEmpty)
                    const LoadingIndicator(),

                  //show history is empty
                  if (vm.historyObjects.isEmpty)
                    const Text('No history found!'),

                  //show the scrollable list of history
                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.historyObjects.length,
                      itemBuilder: (context, index) {
                        final questionModel = vm.historyObjects[index];

                        return Card(
                          color: Colors.lightGreenAccent,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                //display the text
                                Text(
                                  '${questionModel.id}. ${questionModel.testName} \n score : ${questionModel.score} \n Date of attempt : ${questionModel.createdAt}',
                                ),
                              ],
                            ),
                          ),
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
