import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _labels = [
      'Products',
      'Profile',
      'Total Users',
      'Revenue',
      'Orders',
      'Pending',
      'Completed',
      'Ratings',
      'New Customers',
      'Analytics',
    ];

    final List<String> _values = [
      '120',
      'View',
      '1,245',
      '\$12,500',
      '342',
      '28',
      '314',
      '4.8★',
      '45',
      'View',
    ];

    final List<IconData> _icons = [
      Icons.storefront,
      Icons.person,
      Icons.people,
      Icons.attach_money,
      Icons.shopping_cart,
      Icons.hourglass_bottom,
      Icons.check_circle,
      Icons.star,
      Icons.person_add,
      Icons.analytics,
    ];

    final List<Color> _colors = [
      Colors.cyan,
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.purple,
      Colors.indigo,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
          children: List.generate(_labels.length, (i) {
            return _buildDashboardCard(
              title: _labels[i],
              value: _values[i],
              icon: _icons[i],
              color: _colors[i],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color.withOpacity(0.4),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.white,
            ),
            const SizedBox(height: 12.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
