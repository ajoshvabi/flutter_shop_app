import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final List<String> carouselImage = [
  'assets/caro3.jpg',
  'assets/caro4.jpg',
  'assets/caro5.jpg',
  'assets/caro6.jpg',
  'assets/caro1.jpg',
  'assets/caro2.jpg',
];

class _MyAppState extends State<MyApp> {
  List<dynamic> product = [];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    // log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body);
      // final List<dynamic> results = data['results'];
      setState(() {
        product = results;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> filter(category) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
    // log(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body);
      // final List<dynamic> results = data['results'];
      setState(() {
        product = results;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      home: Material(
        child: Scaffold(
          appBar: AppBar(
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () => filter("women's clothing"),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/fashion.jpg',
                                  height: 55,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Fashion",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          GestureDetector(
                            onTap: () => filter("electronics"),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/men.webp',
                                  height: 55,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Electronics",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/women.jpeg',
                                height: 55,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Jewelry",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/toy.webp',
                                height: 55,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Kids",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/toy.webp',
                                height: 55,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Kids",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      // height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    items: carouselImage.map((img) {
                      return Builder(
                        builder: (BuildContext context) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              img,
                              // fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Column(
                    children: product.map((data) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            _navigatorKey.currentState?.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Product(productId: data['id'])),
                            );
                          },
                          child: Builder(
                            builder: (BuildContext context) => Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  // color: const Color.fromARGB(200, 181, 78, 78),
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        data['image'],
                                        height: 150,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['title'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              " ${data['rating']['rate'].toString()}",
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    201, 31, 75, 125),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            RatingBar(
                                              initialRating: data['rating']
                                                      ['rate']
                                                  .toDouble(),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20,
                                              ignoreGestures: true,
                                              ratingWidget: RatingWidget(
                                                full: const Icon(Icons.star,
                                                    color: Colors.orange),
                                                half: const Icon(
                                                    Icons.star_half,
                                                    color: Colors.orange),
                                                empty: const Icon(
                                                    Icons.star_outline,
                                                    color: Colors.orange),
                                              ),
                                              onRatingUpdate: (value) {},
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "( ${data['rating']['count'].toString()})",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '\$ ${data['price'].toString()}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "FREE delivery",
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 198, 26),
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: const Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Add to cart",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
