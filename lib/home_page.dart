import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _currentBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.pushNamed(context, '/about'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // รอรับค่ายอดเงินที่เติมสำเร็จกลับมา
                final result = await Navigator.pushNamed(context, '/topup');
                if (result != null && result is double) {
                  setState(() {
                    _currentBalance += result;
                  });
                }
              },
              child: const Text('เติมเงิน'),
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  '/balancePage',
                  arguments: _currentBalance.toStringAsFixed(2), // ส่งยอดเงินไปแสดง
                );
              },
              child: const Text('Balance / History'),
            ),
            const SizedBox(height: 14,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  '/mylistPage',
                );
              },
              child: const Text('My list page'),
            ),
          ],
        ),
      ),
    );
  }
}