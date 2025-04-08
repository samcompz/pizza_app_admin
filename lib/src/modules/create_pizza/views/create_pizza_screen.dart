import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
        if(state is CreatePizzaSuccess){
          setState(() {
            creationRequired = false;
            context.go('/');
          });
          context.go('/');
        }else if(state is CreatePizzaLoading){
          setState(() {
            creationRequired = true;
          });
        }
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (context, state){
          if(state is UploadPictureLoading){

          }else if(state is UploadPictureSuccess){
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
                      if(image != null && context.mounted){
                        context.read<UploadPictureBloc>().add(UploadPicture(await image.readAsBytes(), basename(image.path)));
                      }
                    },
                    child: pizza.picture.startsWith(('http'))
                        ? Container(width: 400, height: 400, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: NetworkImage(pizza.picture), fit: BoxFit.cover)))
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Add a Picture here...",
                            style: TextStyle(color: Colors.grey),
                          )
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
                            keyboardType: TextInputType.emailAddress,
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
              
                        //Description
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Description',
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
                        //price
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: nameController,
                                  hintText: 'Price',
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
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
                              SizedBox(width: 10),
                              //discount
                              Expanded(
                                child: MyTextField(
                                  controller: nameController,
                                  hintText: 'Discount',
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  suffixIcon: const Icon(
                                    CupertinoIcons.percent,
                                    color: Colors.grey,
                                  ),
                                  errorMsg: "Error",
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
                            Checkbox(value: false, onChanged: (value) {}),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text('Is Spicy: '),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                    border: Border.all(width: 2)
                                  ),
                                ),
              
                                SizedBox(width: 10),
              
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                      border: Border.all(width: 2)
                                  ),
                                ),
              
                                SizedBox(width: 10),
              
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                      border: Border.all(width: 2)
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
              
                        SizedBox(width: 10),
              
                        Text(
                          'Macros: '
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              MyMacroWidget(
                                title: "Calories",
                                value:pizza.macros.calories,
                                icon:FontAwesomeIcons.fire,
                              ),
                              SizedBox(width: 10),
              
                              MyMacroWidget(
                                title: "Proeins",
                                value:pizza.macros.proteins,
                                icon:FontAwesomeIcons.dumbbell,
                              ),
                              SizedBox(width: 10),
              
                              MyMacroWidget(
                                title: "Fat",
                                value:pizza.macros.fat,
                                icon:FontAwesomeIcons.oilWell,
                              ),
                              SizedBox(width: 10),
              
                              MyMacroWidget(
                                title: "Carbs",
                                value:pizza.macros.carbs,
                                icon:FontAwesomeIcons.breadSlice,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        )
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
