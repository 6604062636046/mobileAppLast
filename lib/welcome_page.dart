import 'package:flutter/material.dart';
import 'package:water/about_page.dart';
import 'package:water/display_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
class _WelcomePageState extends State<WelcomePage> {
  String _output = '';
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    debugPrint('initStatge');
    _output = 'Enter your name';
  }

  @override 
  void dispose(){
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'About Us',
            onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutPage(),
              ),
              );
            },
          )
        ],
      ),

      body: Center(
        child: Column(
          children: [
            const Text('Welcome to my App'),

            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                labelText: 'Name',
              ),
            ),

            Text(
              '${_output}'),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                String input = _textController.text;
                //debugPrint('pressed btn');
                debugPrint('Input: $input');
                setState(() {
                  _output = 'สวัสดีฮ้าฟฟฟฟ \nยินดีต้อนรับค้าบพี่น้อง';
                });
              },
              child: const Text('Click me'),
            ),
            const SizedBox(height: 14,),
            ElevatedButton(onPressed: (){
              String input = _textController.text;
              int inputAge = 22;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisplayPage(
                  name: input,
                  age: inputAge,
                  ),
                ),
              );
            },
            child: const Text(
              'Display on Next Page',
            ),
            ),

            const SizedBox(height: 34,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context,
                '/about',
              );
            },
            child: const Text(
              'About Us'
            ),
            ),

            const SizedBox(height: 14,),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context,
                '/display',
              );
            },
            child: const Text('Display Page'),
            ),
          ],
        ),
      ),
    );
  }
}