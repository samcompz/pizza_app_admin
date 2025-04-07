import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              SizedBox(width: 20),
              //
              Expanded(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
          )
        ],
      ),
    );
  }
}
