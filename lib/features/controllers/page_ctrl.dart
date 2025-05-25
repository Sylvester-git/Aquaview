import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterapp/features/cubit/current_page/current_page_cubit.dart';
import 'package:waterapp/util/enums.dart';

class PageCtrl {
  static void changeCurrenPage({
    required BuildContext context,
    required CurrenPages page,
  }) => context.read<CurrentPageCubit>().changePage(page: page);
}
