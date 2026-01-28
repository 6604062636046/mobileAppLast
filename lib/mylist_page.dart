import 'package:flutter/material.dart';
import 'package:water/detail_page.dart';
//import 'about_page.dart';
import 'catalog_products.dart';

class MylistPage extends StatelessWidget {
  const MylistPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 255, 242),
      appBar: AppBar(title: const Text('My List Page')),

      body: ListView.separated(
        itemCount: CatalogProducts.items.length,
        itemBuilder: (context,index) => ListTile(
          leading: Image.network(CatalogProducts.items[index].imageURL),
          title: Text(CatalogProducts.items[index].title),
          subtitle: Text(CatalogProducts.items[index].desc),

          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(
              product: CatalogProducts.items[index],
            )),
          ),
          ),
          separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}