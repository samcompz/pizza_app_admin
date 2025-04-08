import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'models/models.dart';

abstract class PizzaRepo{
  Future<List<Pizza>> getPizzas();

  Future<String> sendImage(Uint8List file, String name);

  Future<void> createPizzas(Pizza pizza);
}