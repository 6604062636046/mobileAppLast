import 'package:flutter/material.dart';
import 'catalog_products.dart';
import 'models/product.dart';

class DetailPage extends StatelessWidget {
  final Product product; 

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            Image.network(product.imageURL, height: 250),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(product.desc),
            ),
          ],
        ),
      ),
    );
  }
}