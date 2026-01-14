import 'package:flutter/material.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('เติมเงิน', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'ใส่จำนวนเงิน'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(hintText: 'Note:'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    '/topupReport',
                    arguments: {
                      'amount': _amountController.text,
                      'note': _noteController.text,
                    },
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}