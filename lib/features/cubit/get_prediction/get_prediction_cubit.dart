import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waterapp/features/model/prediction.dart';
import 'package:waterapp/network/api_repo.dart';

part 'get_prediction_state.dart';

class GetPredictionCubit extends Cubit<GetPredictionState> {
  final ApiRepo _apiRepo;
  GetPredictionCubit(this._apiRepo) : super(GetPredictionInitial());

  Future<void> getPrediction() async {
    emit(GettingPrediction());
    final res = await _apiRepo.getPrediction();
    res.fold(
      (l) {
        emit(ErrorGettingPrediction(errormessage: l.message));
      },
      (r) {
        emit(GottenPrediction(prediction: r));
      },
    );
  }

  Future<void> refreshPrediction() async {
    final res = await _apiRepo.getPrediction();
    res.fold((l) {}, (r) {
      emit(GottenPrediction(prediction: r));
    });
  }
}
