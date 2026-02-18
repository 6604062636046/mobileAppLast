import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _loading = true;
  String? _error;
  List<dynamic> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    const url = 'https://itpart.net/mobile/api/products.php';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final body = res.body;
        final data = json.decode(body);
        if (data is List) {
          // assign items then resolve image URLs
          _items = data;
          await _resolveImagesForItems(_items);
          setState(() {
            _loading = false;
          });
        } else if (data is Map && data['products'] is List) {
          _items = List.from(data['products']);
          await _resolveImagesForItems(_items);
          setState(() {
            _loading = false;
          });
        } else {
          setState(() {
            _error = 'Unexpected response format';
            _loading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Failed to load products: ${res.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _resolveImagesForItems(List<dynamic> items) async {
    for (final item in items) {
      if (item is Map) {
        String? raw;
        for (final k in ['imageUrl', 'image', 'img', 'picture', 'photo', 'thumb', 'thumbnail', 'image_url', 'picture_url', 'img_url']) {
          final v = item[k];
          if (v != null && v.toString().trim().isNotEmpty) {
            raw = v.toString().trim();
            break;
          }
        }
        if (raw != null) {
          final resolved = await _findReachableImage(raw);
          if (resolved != null) {
            item['_resolvedImage'] = resolved;
          }
        }
      }
    }
  }

  Future<String?> _findReachableImage(String raw) async {
    try {
      if (raw.startsWith('http')) return raw;

      // Clean the filename
      var name = raw.replaceAll('\n', ' ').trim();
      name = name.replaceAll(RegExp(r'\s+'), ' ');

      // Candidate bases (try in order)
      final bases = [
        'https://itpart.net/mobile/api/',
        'https://itpart.net/mobile/images/',
        'https://itpart.net/uploads/',
        'https://itpart.net/images/',
        'https://itpart.net/mobile/',
      ];

      for (final base in bases) {
        final encoded = name.replaceAll(' ', '%20');
        final url = base + encoded;
        try {
          final head = await http.head(Uri.parse(url));
          if (head.statusCode == 200) return url;
        } catch (_) {
          // ignore and try next
        }
      }
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Error: $_error'))
                : _items.isEmpty
                    ? const Center(child: Text('No products'))
                    : ListView.separated(
                        itemCount: _items.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          if (item is Map) {
                            final title = item['name'] ?? item['title'] ?? item['product'] ?? item['p_name'] ?? item.toString();
                            final subtitle = item['price'] != null ? 'Price: ${item['price']}' : (item['description'] ?? '');

                            // Prefer resolved absolute URL, otherwise try common image keys
                            String? imageUrl = item['_resolvedImage'] as String?;
                            if (imageUrl == null) {
                              for (final k in ['imageUrl','image', 'img', 'picture', 'photo', 'thumb', 'thumbnail', 'image_url', 'picture_url', 'img_url']) {
                                final v = item[k];
                                if (v != null && v.toString().trim().isNotEmpty) {
                                  final raw = v.toString().trim();
                                  if (raw.startsWith('http')) {
                                    imageUrl = raw;
                                  } else {
                                    // try a likely base path
                                    imageUrl = 'https://itpart.net/mobile/api/' + raw.replaceAll(' ', '%20');
                                  }
                                  break;
                                }
                              }
                            }

                            Widget leading;
                            if (imageUrl != null) {
                              leading = ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  imageUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => const Icon(Icons.broken_image),
                                ),
                              );
                            } else {
                              leading = const CircleAvatar(child: Icon(Icons.storefront));
                            }

                            return ListTile(
                              leading: leading,
                              title: Text(title.toString()),
                              subtitle: Text(subtitle.toString()),
                              onTap: () {
                                final Map<String, dynamic> map = Map<String, dynamic>.from(item as Map);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(item: map),
                                ));
                              },
                            );
                          }

                          return ListTile(
                            title: Text(item.toString()),
                          );
                        },
                      ),
      ),
    );
  }
}


class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ProductDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = item['name'] ?? item['title'] ?? item['product'] ?? item['p_name'] ?? 'Product';
    final price = item['price']?.toString();
    final description = item['description'] ?? item['detail'] ?? item['desc'] ?? '';

    // Prefer previously resolved absolute URL
    String? imageUrl = item['_resolvedImage'] as String?;
    if (imageUrl == null) {
      for (final k in ['imageUrl','image', 'img', 'picture', 'photo', 'thumb', 'thumbnail', 'image_url', 'picture_url', 'img_url']) {
        final v = item[k];
        if (v != null && v.toString().trim().isNotEmpty) {
          final raw = v.toString().trim();
          if (raw.startsWith('http')) {
            imageUrl = raw;
          } else {
            imageUrl = 'https://itpart.net/mobile/api/' + raw.replaceAll(' ', '%20');
          }
          break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(title.toString())),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (imageUrl != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image, size: 64)),
                ),
              )
            else
              Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.storefront, size: 64)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toString(),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (price != null) Text('Price: $price', style: const TextStyle(fontSize: 18, color: Colors.green)),
                  const SizedBox(height: 12),
                  if (description != null && description.toString().isNotEmpty)
                    Text(description.toString()),
                  const SizedBox(height: 16),
                  const Divider(),
                  ...item.entries
                      .where((e) => !['name', 'title', 'product', 'p_name', 'price', 'description', 'detail', 'img', 'image', 'picture', 'photo', 'thumb', 'thumbnail', 'image_url', 'picture_url', 'img_url'].contains(e.key))
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 3, child: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold))),
                                const SizedBox(width: 8),
                                Expanded(flex: 7, child: Text(e.value.toString())),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
