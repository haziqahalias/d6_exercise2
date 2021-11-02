abstract class UserInputsState {}

extension Capitalized on String {
  String capitalized() =>
      this.substring(0, 1).toUpperCase() + this.substring(1).toLowerCase();
}

class DetectUserInputsFilledState extends UserInputsState {}

class DetectUserInputsEmptyState extends UserInputsState {}

class CapitalizeState extends UserInputsState {
  late String userStr;

  CapitalizeState(String inputData) {
    userStr = inputData.capitalized();
  }
}
