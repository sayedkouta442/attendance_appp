import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  textStyle: WidgetStatePropertyAll(
                      TextStyle(fontSize: 16, color: Colors.white)),
                ),
                // autofocus: true,
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return const MapScreen();
                  // }));
                },
                child: const Text(
                  'Check In',
                  //  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    )));
  }
}
