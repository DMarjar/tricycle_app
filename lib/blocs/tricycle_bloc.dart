import 'package:bloc/bloc.dart';
import '../repositories/tricycle_repository.dart';
import 'tricycle_event.dart';
import 'tricycle_state.dart';

class TricycleBloc extends Bloc<TricycleEvent, TricycleState> {
  final TricycleRepository tricycleRepository;

  TricycleBloc(this.tricycleRepository) : super(TricyclesLoading()) {
    on<GetAllTricycles>(_onGetAllTricycles);
    on<SaveTricycle>(_onSaveTricycle);
    on<UpdateTricycle>(_onUpdateTricycle);
    on<DeleteTricycle>(_onDeleteTricycle);
  }

  void _onGetAllTricycles(
      GetAllTricycles event, Emitter<TricycleState> emit) async {
    try {
      final tricycles = await tricycleRepository.getAllTricycles();
      emit(TricyclesLoaded(tricycles));
    } catch (e) {
      emit(TricyclesError(e.toString()));
    }
  }

  void _onSaveTricycle(SaveTricycle event, Emitter<TricycleState> emit) async {
    if (state is TricyclesLoaded || state is TricyclesLoading) {
      try {
        await tricycleRepository.saveTricycle(event.tricycle);
        final tricycles = await tricycleRepository.getAllTricycles();
        emit(TricyclesLoaded(tricycles));
      } catch (e) {
        emit(TricyclesError(e.toString()));
      }
    }
  }

  void _onUpdateTricycle(
      UpdateTricycle event, Emitter<TricycleState> emit) async {
    if (state is TricyclesLoaded) {
      try {
        await tricycleRepository.updateTricycle(event.tricycle);
        final tricycles = await tricycleRepository.getAllTricycles();
        emit(TricyclesLoaded(tricycles));
      } catch (e) {
        emit(TricyclesError(e.toString()));
      }
    }
  }

  void _onDeleteTricycle(
      DeleteTricycle event, Emitter<TricycleState> emit) async {
    if (state is TricyclesLoaded) {
      try {
        await tricycleRepository.deleteTricycle(event.id);
        final tricycles = await tricycleRepository.getAllTricycles();
        emit(TricyclesLoaded(tricycles));
      } catch (e) {
        emit(TricyclesError(e.toString()));
      }
    }
  }
}
