import 'package:equatable/equatable.dart';
import 'package:tricycle_app/models/tricycle_save.dart';
import '../models/tricycle.dart';

abstract class TricycleEvent extends Equatable {
  const TricycleEvent();

  @override
  List<Object> get props => [];
}

class GetAllTricycles extends TricycleEvent {}

class SaveTricycle extends TricycleEvent {
  final TricycleSave tricycle;

  const SaveTricycle(this.tricycle);

  @override
  List<Object> get props => [tricycle];
}

class UpdateTricycle extends TricycleEvent {
  final Tricycle tricycle;

  const UpdateTricycle(this.tricycle);

  @override
  List<Object> get props => [tricycle];
}

class DeleteTricycle extends TricycleEvent {
  final int id;

  const DeleteTricycle(this.id);

  @override
  List<Object> get props => [id];
}
