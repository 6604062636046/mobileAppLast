import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  //const DisplayPage({super.key});
  final String name;
  final int? age;

  const DisplayPage({super.key, required this.name, this.age});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 14,),
            Text(
              'Hi, ${widget.name} \nAge: ${widget.age}',
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}