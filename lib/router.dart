import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './ui/views/screens/all.dart';

class Router {
  static initial() => 'login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'home':
        // return MaterialPageRoute(builder: (_) => HomeScreen());
        return MaterialPageRoute(builder: (_) => ListScreen());
      case 'detail':
        return MaterialPageRoute(
            builder: (_) => DetailView(id: settings.arguments));
      case 'camera':
        return MaterialPageRoute(builder: (_) => CameraView());
      case 'qr':
        return MaterialPageRoute(builder: (_) => QRScreen());
      case 'meter':
        return MaterialPageRoute(builder: (_) => MeterDetailView());
      default:
        return MaterialPageRoute(
            builder: (_) => NotFoundView(title: settings.name));
    }
  }
}
