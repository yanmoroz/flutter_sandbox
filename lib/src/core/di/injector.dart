import 'package:get_it/get_it.dart';

import '../../feature/todo/assembly/todo_assembly.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Register all feature modules here
  TodoAssembly.register(sl);
}
