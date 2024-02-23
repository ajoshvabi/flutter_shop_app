import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class Product extends StatelessWidget {
  final int productId;

  const Product({Key? key, required this.productId}) : super(key: key);

  Future<Map<String, dynamic>> fetchProductDetails() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/$productId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            // appBar: AppBar(
            //   title: const Text('Product Details'),
            // ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Product Details'),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final productDetails = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.lightBlueAccent,
              title: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        labelText: 'Search Amazon.in',
                        labelStyle: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black45,
                            size: 24,
                          ),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.black45,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic,
                                color: Colors.black45,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        productDetails['image'],
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.longestSide * 0.55,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    productDetails['title'],
                    style: const TextStyle(
                        fontSize: 18, height: 1.5, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$ ${productDetails['price']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        productDetails['rating']['rate'].toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(201, 31, 75, 125),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 3),
                      RatingBar(
                        initialRating: productDetails['rating']['rate'],
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        ignoreGestures: true,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half:
                              const Icon(Icons.star_half, color: Colors.orange),
                          empty: const Icon(Icons.star_outline,
                              color: Colors.orange),
                        ),
                        onRatingUpdate: (value) {},
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '(${productDetails['rating']['count']})',
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Samsung 49 inch gaiming mornitor",
                    // productDetails['description'],
                    style: TextStyle(
                        fontSize: 18, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 255, 198, 26),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 11, bottom: 11),
                          child: const Text(
                            'Add to cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 255, 137, 10),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 11, bottom: 11),
                          child: const Text(
                            'Buy Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
