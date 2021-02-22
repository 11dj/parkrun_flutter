import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
// import 'package:mobile_uploader/core/models/all.dart';
import 'locator_setup.dart';

List<SingleChildWidget> providers = [...providerModels];

List<SingleChildWidget> providerModels = [
  // ChangeNotifierProvider<User>(create: (context) => User()),
  // StreamProvider<TestA>(create: (context) => TestA().intStream()),
  // StreamProvider<TestA>(
  //   // initialData: TestA(),
  //   create: (context) => TestA().intStream(),
  //   ),
  // StreamProvider<TestA>.value(value: TestA().createStreamTestA()),
  // ChangeNotifierProvider<User>(create: (context) => locator<User>()),
  // ChangeNotifierProvider<Setting>(create: (context) => locator<Setting>()),
  // ChangeNotifierProxyProvider<TestAModel, TestA>(
  //   create: (_) => TestA(),
  //   update: (_, testAModel, testA) => testA
  //   ..update(testAModel),
  // ),
  // ChangeNotifierProxyProvider2(create: null, update: null)
];
