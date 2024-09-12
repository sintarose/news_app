import 'package:news_app/controller/data_controller.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerDeclaration = [
  ChangeNotifierProvider(create: (_) => DataController()),
];
