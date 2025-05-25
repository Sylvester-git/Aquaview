import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waterapp/network/api_repo.dart';

import '../../model/wqms.dart';

part 'get_sensor_data_state.dart';

class GetSensorDataCubit extends Cubit<GetSensorDataState> {
  final ApiRepo _apiRepo;
  GetSensorDataCubit(this._apiRepo) : super(GetSensorDataInitial());

  Future<void> loadSensorData() async {
    emit(GettingSensorData());
    final res = await _apiRepo.getSensorData();
    res.fold(
      (l) {
        emit(ErrorGettingSensorData(errormessage: l.message));
      },
      (r) {
        emit(GottenSensorData(sensorData: r));
      },
    );
  }

  Future<void> refreshSensorData() async {
    final res = await _apiRepo.getSensorData();
    res.fold((l) {}, (r) {
      emit(GottenSensorData(sensorData: r));
    });
  }
}
