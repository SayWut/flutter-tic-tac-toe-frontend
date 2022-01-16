import 'package:get/get.dart';

import 'controllers/tic_tac_toe_conroller.dart';

Future<void> initIngection() async {
  await Get.putAsync(() async => TicTacToeConroller());
}
