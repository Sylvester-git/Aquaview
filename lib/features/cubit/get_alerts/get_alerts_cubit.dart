import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waterapp/features/model/alerts.dart';
import 'package:waterapp/network/api_repo.dart';

part 'get_alerts_state.dart';

class GetAlertsCubit extends Cubit<GetAlertsState> {
  final ApiRepo _apiRepo;
  GetAlertsCubit(this._apiRepo) : super(GetAlertsInitial());

  Future<void> getAlerts() async {
    emit(GettingAlerts());
    final res = await _apiRepo.getAlerts();
    res.fold(
      (l) {
        emit(ErrorGettingAlerts(errormessage: l.message));
      },
      (r) {
        emit(GottenAlerts(alerts: r));
      },
    );
  }

  Future<void> refreshAlerts() async {
    final res = await _apiRepo.getAlerts();
    res.fold((l) {}, (r) {
      emit(GottenAlerts(alerts: r));
    });
  }
}
