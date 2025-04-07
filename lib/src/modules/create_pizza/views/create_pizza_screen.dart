import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_ap_admin/src/components/my_text_field.dart';

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

  final _formKey = GlobalKey<FormState>();

  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a New Pizza !',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            SizedBox(height: 20),
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
    );
  }
}
