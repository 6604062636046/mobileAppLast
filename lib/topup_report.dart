import 'package:flutter/material.dart';

class TopupReport extends StatelessWidget {
  const TopupReport({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String amountStr = args?['amount'] ?? '0.00';
    final String note = args?['note'] ?? 'ไม่มีบันทึก';

    return Scaffold(
      appBar: AppBar(title: const Text('Top Up Report')),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            Text('เติมเงินเรียบร้อย', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const Divider(indent: 40, endIndent: 40),
            Text('ยอดเงิน: $amountStr บาท', style: const TextStyle(fontSize: 20)),
            Text('บันทึก: $note', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountStr) ?? 0.0;
                Navigator.pop(context); // ปิดหน้า Report
                Navigator.pop(context, amount); // ปิดหน้า Topup พร้อมส่งค่าเงินกลับไป
              },
              child: const Text('กลับหน้าหลัก'),
            )
          ],
        ),
      ),
    );
  }
}