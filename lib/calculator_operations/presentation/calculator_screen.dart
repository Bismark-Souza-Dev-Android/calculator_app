import 'package:ccapp/calculator_operations/blocs/calculator_bloc.dart';
import 'package:ccapp/calculator_operations/blocs/calculator_state.dart';
import 'package:ccapp/calculator_operations/infra/input_memory_handle.dart';
import 'package:ccapp/calculator_operations/infra/input_operations_handle.dart';
import 'package:ccapp/calculator_operations/presentation/widget/calculator_button_grid.dart';
import 'package:ccapp/calculator_operations/presentation/widget/memory_dialogue.dart';
import 'package:ccapp/core/app_colors.dart';
import 'package:ccapp/core/calculator_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final List<String> _listButtons = CalculatorListItems.getListButtons();
  final List<String> _listMemories = CalculatorListItems.getListMemories();
  final InputOperationsHandle inputOperationsHandle = InputOperationsHandle();
  final InputMemoryHandle inputMemoryHandle = InputMemoryHandle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          title: Text(
            'Calculator App',
            style: TextStyle(color: AppColors.fontColor),
          ),
          backgroundColor: AppColors.blackColor,
        ),
        body: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              AppColors.gradientInitialFieldColor
                                  .withValues(alpha: 0.7),
                              AppColors.equalButtonColor.withValues(alpha: 0.5)
                            ])),
                        child: BlocListener<CalculatorBloc, CalculatorState>(
                          listener: (context, state) {
                            if (state is CalculatorMemoryView) {
                              showDialog(
                                context: context,
                                builder: (_) => MemoryDialogue(
                                  memoryValue: state.memoryValue,
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.expression,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  state.result,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CalculatorButtonGrid(
                        items: _listMemories,
                        hasMemory: state.hasMemory,
                        onTap: (input) {
                          final bloc = context.read<CalculatorBloc>();
                          inputMemoryHandle.handleMemoryInput(input, bloc);
                        },
                        isMemories: true,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CalculatorButtonGrid(
                          items: _listButtons,
                          onTap: (input) {
                            final bloc = context.read<CalculatorBloc>();
                            inputOperationsHandle.handleInputOperation(
                                input, bloc);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
