import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:day6_exercise2/blocs/input_state.dart';

class DetectUserInput extends Cubit<UserInputsState> {
  DetectUserInput() : super(DetectUserInputsEmptyState());

  void validCheck() {
    emit(DetectUserInputsFilledState());
  }

  void invalidCheck() {
    emit(DetectUserInputsEmptyState());
  }

  void toCapital(String userInput) {
    emit(CapitalizeState(userInput));
  }
}