
import 'package:bloc/bloc.dart';

import '../model/home_response/home_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


}
