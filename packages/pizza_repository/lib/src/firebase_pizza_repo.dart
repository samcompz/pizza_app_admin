import 'dart:math';
import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pizza_repository/pizza_repository.dart';

class FirebasePizzaRepo implements PizzaRepo{
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');


  @override
  Future<List<Pizza>> getPizzas() async {
    final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

   try{
     return await pizzaCollection
     .get()
     .then((value) => value.docs.map((e) =>
     Pizza.fromEntity(PizzaEntity.fromDocument(e.data())))
         .toList());
   }catch(e){
     log(e.toString() as num);
     rethrow;
   }
  }

  @override
  Future<void> createPizzas(Pizza pizza) async {
    try{
      return await pizzaCollection
      .doc(pizza.pizzaId)
      .set(pizza.toEntity().toDocument());

    }catch(e){
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> sendImage(Uint8List file, String name) async {
    try{
      Reference firebaseStorageRef = FirebaseFirestore
          .instance
          .ref()
          .child(name);

      await FirebaseStorageRef.putData(
        file,
        SettableMetadata(
          contentType: 'image/jpeg',
          //
        )
      );
      return await firebaseStorageRef.getDownloadURL();
    }catch(e){
      log(e.toString());
      rethrow;
    }
    throw UnimplementedError();
  }
  
}