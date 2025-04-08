import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pizza_ap_admin/src/components/my_text_field.dart';
import 'package:pizza_ap_admin/src/modules/create_pizza/blocs/create_pizza_bloc/create_pizza_bloc.dart';
import 'package:pizza_ap_admin/src/modules/create_pizza/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

import '../components/macro.dart';

class CreatePizzaScreen extends StatefulWidget {
  const CreatePizzaScreen({super.key});

  @override
  State<CreatePizzaScreen> createState() => _CreatePizzaScreenState();
}

class _CreatePizzaScreenState extends State<CreatePizzaScreen> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final discController = TextEditingController();
  final calorieController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _errorMsg;

  bool creationRequired = false;

  late Pizza pizza;

  @override
  void initState() {
    pizza = Pizza.empty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePizzaBloc, CreatePizzaState>(
      listener: (BuildContext context, CreatePizzaState state) {
        if (state is CreatePizzaSuccess) {
          setState(() {
            creationRequired = false;
            context.go('/');
          });
          context.go('/');
        } else if (state is CreatePizzaLoading) {
          setState(() {
            creationRequired = true;
          });
        }
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (context, state) {
          if (state is UploadPictureLoading) {
          } else if (state is UploadPictureSuccess) {
            setState(() {
              pizza.picture = state.url;
            });
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create a New Pizza !',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),

                  SizedBox(height: 20),

                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                      );
                      if (image != null && context.mounted) {
                        context.read<UploadPictureBloc>().add(
                          UploadPicture(
                            await image.readAsBytes(),
                            basename(image.path),
                          ),
                        );
                      }
                    },
                    child:
                        pizza.picture.startsWith(('http'))
                            ? Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(pizza.picture),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            : Ink(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.photo,
                                    size: 100,
                                    color: Colors.grey.shade200,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Add a Picture here...",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                  ),

                  Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Name',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            // prefixIcon: const Icon(CupertinoIcons.mail_solid),
                            errorMsg: "Error",
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        //Description
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Description',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            // prefixIcon: const Icon(CupertinoIcons.mail_solid),
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        //price
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: priceController,
                                  hintText: 'Price',
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  // prefixIcon: const Icon(CupertinoIcons.mail_solid),
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(width: 10),

                              //discount
                              Expanded(
                                child: MyTextField(
                                  controller: discController,
                                  hintText: 'Discount',
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const Icon(
                                    CupertinoIcons.percent,
                                    color: Colors.grey,
                                  ),
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Text('Is Vege: '),
                            SizedBox(width: 10),
                            Checkbox(
                              value: false,
                              onChanged: (value) {
                                setState(() {
                                  pizza.isVeg = value!;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(width: 10),

                        Row(
                          children: [
                            Text('Is Spicy: '),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizza.spicy = 1;
                                    });
                                  },
                                  child: Ink(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          pizza.spicy == 1
                                              ? Border.all(width: 2)
                                              : null,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizza.spicy = 2;
                                    });
                                  },
                                  child: Ink(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          pizza.spicy == 1
                                              ? Border.all(width: 2)
                                              : null,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    setState(() {
                                      pizza.spicy = 3;
                                    });
                                  },
                                  child: Ink(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          pizza.spicy == 1
                                              ? Border.all(width: 2)
                                              : null,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(width: 10),

                        Text('Macros: '),

                        SizedBox(width: 10),

                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              MyMacroWidget(
                                title: "Calories",
                                value: pizza.macros.calories,
                                icon: FontAwesomeIcons.fire,
                                controller: calorieController,
                              ),
                              SizedBox(width: 10),

                              MyMacroWidget(
                                title: "Proteins",
                                value: pizza.macros.proteins,
                                icon: FontAwesomeIcons.dumbbell,
                                controller: proteinController,
                              ),
                              SizedBox(width: 10),

                              MyMacroWidget(
                                title: "Fat",
                                value: pizza.macros.fat,
                                icon: FontAwesomeIcons.oilWell,
                                controller: fatController,
                              ),
                              SizedBox(width: 10),

                              MyMacroWidget(
                                title: "Carbs",
                                value: pizza.macros.carbs,
                                icon: FontAwesomeIcons.breadSlice,
                                controller: carbsController,
                              ),
                              SizedBox(width: 20),

                              !creationRequired
                              ? SizedBox(
                                width: 400,
                                height: 40,
                                child: TextButton(
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                        setState(() {
                                          pizza.name = nameController.text;
                                          pizza.description = descController.text;
                                          pizza.price = int.parse(priceController.text);
                                          pizza.discount = int.parse(discController.text);
                                          pizza.macros.calories = int.parse(calorieController.text);
                                          pizza.macros.proteins = int.parse(proteinController.text);
                                          pizza.macros.fat = int.parse(fatController.text);
                                          pizza.macros.carbs = int.parse(carbsController.text);
                                        });
                                        if (kDebugMode) {
                                          print(pizza.toString());
                                        }
                                        context.read<CreatePizzaBloc>().add(CreatePizza(pizza));
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                        elevation: 3.0,
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(60),
                                        ),
                                    ),
                                  child: Text(
                                    'Create Pizza',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                                  : const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
