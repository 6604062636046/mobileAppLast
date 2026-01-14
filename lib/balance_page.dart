import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // รับค่ายอดเงินที่ส่งมาจากหน้า HomePage
    final String balance = ModalRoute.of(context)?.settings.arguments as String? ?? "0.00";

    return Scaffold(
      appBar: AppBar(title: const Text('Balance / History')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 100, color: Colors.blue),
            const Text('ยอดเงินคงเหลือปัจจุบัน', style: TextStyle(fontSize: 18)),
            Text(
              '$balance บาท',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('กลับ'),
            )
          ],
        ),
      ),
    );
  }
}