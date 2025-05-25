import 'package:bloc/bloc.dart';
import 'package:waterapp/util/enums.dart';

class CurrentPageCubit extends Cubit<CurrenPages> {
  CurrentPageCubit() : super(CurrenPages.dashboard);

  void changePage({required CurrenPages page}) {
    emit(page);
  }
}
