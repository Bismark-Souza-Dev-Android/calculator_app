import 'package:ccapp/blocs/calculator_bloc.dart';
import 'package:ccapp/blocs/calculator_event.dart';
import 'package:ccapp/blocs/calculator_state.dart';
import 'package:ccapp/core/app_colors.dart';
import 'package:ccapp/core/calculator_items.dart';
import 'package:ccapp/feature/calculator/presentation/widget/calculator_button_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final List<String> _listButtons = CalculatorListItems.getListButtons();
  final List<String> _listMemories = CalculatorListItems.getListMemories();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF202020),
        appBar: AppBar(
          title: Text(
            'Calculator App',
            style: TextStyle(color: AppColors.fontColor),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          AppColors.gradientInitialFieldColor
                              .withValues(alpha: 0.5),
                          AppColors.gradientFinalFieldColor
                              .withValues(alpha: 0.5)
                        ])),
                    child: BlocBuilder<CalculatorBloc, CalculatorState>(
                        builder: (context, state) {
                      if (state is CalculatorLoaded) {
                        return Container(
                          height: 60,
                          width: 400,
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color(0xFF323232),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  textAlign: TextAlign.right,
                                  state.expression,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  textAlign: TextAlign.right,
                                  state.result,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                  ),
                ),
                Expanded(
                  child: CalculatorButtonGrid(
                    items: _listMemories,
                    hasMemory: true,
                    onTap: (input) {
                      final bloc = context.read<CalculatorBloc>();
                      if (RegExp(r'^\d+$').hasMatch(input)) {
                        bloc.add(NumberPressed(input));
                      } else if (input == '=') {
                        bloc.add(EqualPressed());
                      } else if (input == 'C') {
                        bloc.add(ClearPressed());
                      } else {
                        bloc.add(OperationPressed(input));
                      } else if (input == 'CE') {
                        bloc.add(ClearEntryPressed());
                        } else if (input == '<=') {
                        bloc.add(BackspacePressed());
                        } 
                    },
                   isMemories: true,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CalculatorButtonGrid(
                        items: _listButtons,
                        onTap: (input) {
                          final bloc = context.read<CalculatorBloc>();
                          if (RegExp(r'^\d+$').hasMatch(input)) {
                            bloc.add(NumberPressed(input));
                          } else if (input == '=') {
                            bloc.add(EqualPressed());
                          } else if (input == 'C') {
                            bloc.add(ClearPressed());
                          } else if (input == 'CE') {
                            bloc.add(ClearEntryPressed());
                          } else {
                            bloc.add(OperationPressed(input));
                          }}
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
