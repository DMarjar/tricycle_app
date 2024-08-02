import 'package:equatable/equatable.dart';
import '../models/tricycle.dart';

abstract class TricycleState extends Equatable {
  const TricycleState();

  @override
  List<Object> get props => [];
}

class TricyclesLoading extends TricycleState {}

class TricyclesLoaded extends TricycleState {
  final List<Tricycle> tricycles;

  const TricyclesLoaded(this.tricycles);

  @override
  List<Object> get props => [tricycles];
}

class TricyclesError extends TricycleState {
  final String message;

  const TricyclesError(this.message);

  @override
  List<Object> get props => [message];
}
