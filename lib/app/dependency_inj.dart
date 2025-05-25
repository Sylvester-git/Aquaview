import 'package:get_it/get_it.dart';
import 'package:waterapp/features/cubit/get_prediction/get_prediction_cubit.dart';
import 'package:waterapp/features/cubit/get_sensor_data/get_sensor_data_cubit.dart';
import 'package:waterapp/network/api.dart';
import 'package:waterapp/network/api_ds.dart';
import 'package:waterapp/network/api_repo.dart';

final instance = GetIt.instance;
Future<void> initDependencyInj() async {
  // DIO API
  instance.registerLazySingleton<Api>(() => Api());

  //Datasource
  instance.registerLazySingleton<ApiDS>(() => ApiDsImpl(api: instance()));

  //Repository
  instance.registerLazySingleton<ApiRepo>(() => ApiRepoImpl(apiDS: instance()));

  //Cubit
  instance.registerLazySingleton<GetSensorDataCubit>(
    () => GetSensorDataCubit(instance()),
  );
  instance.registerLazySingleton<GetPredictionCubit>(
    () => GetPredictionCubit(instance()),
  );
}
