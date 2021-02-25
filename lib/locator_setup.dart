import 'package:get_it/get_it.dart';

import 'package:parkrun_app/core/models/all.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<Temp>(Temp());
}
