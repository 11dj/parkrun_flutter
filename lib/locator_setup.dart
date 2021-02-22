import 'package:get_it/get_it.dart';
// import 'package:mobile_uploader/core/models/all.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // locator.registerSingleton<Setting>(Setting());
  // locator.registerSingleton<User>(User());

// Alternatively you could write it if you don't like global variables
  // GetIt.I.registerSingleton<AppModel>(AppModel());
}
