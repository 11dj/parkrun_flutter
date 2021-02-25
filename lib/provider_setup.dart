import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:parkrun_app/core/models/all.dart';
import 'locator_setup.dart';

List<SingleChildWidget> providers = [...providerModels];

List<SingleChildWidget> providerModels = [
  ChangeNotifierProvider<Temp>(create: (context) => locator<Temp>()),
];
