part of 'machine_learning_cubit.dart';

abstract class MachineLearningState extends Equatable {
  const MachineLearningState();

  @override
  List<Object> get props => [];
}

class MachineLearningInitial extends MachineLearningState {}

class MachineLearningLoadingState extends MachineLearningState {}

class MachineLearningLoadedState extends MachineLearningState {
  final String label;
  const MachineLearningLoadedState({required this.label});
}
