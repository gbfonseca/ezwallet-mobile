import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/start_page.dart';
import 'presentation/submodules/home/home_module.dart';
import 'start_store.dart';

class StartModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StartStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => StartPage(), children: [
      ModuleRoute(
        '/home/',
        module: HomeModule(),
        transition: TransitionType.rightToLeftWithFade,
      ),
    ]),
  ];
}