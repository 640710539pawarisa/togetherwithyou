import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Cartoon {
  final String title;
  final String image;

  Cartoon({required this.title, required this.image});

  factory Cartoon.fromJson(Map<String, dynamic> json) {
    return Cartoon(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartoon List',
      home: CartoonListPage(),
    );
  }
}

class CartoonListPage extends StatefulWidget {
  @override
  _CartoonListPageState createState() => _CartoonListPageState();
}

class _CartoonListPageState extends State<CartoonListPage> {
  late Future<List<Cartoon>> _cartoonsFuture;
  late TextEditingController _searchController;


@override
  void initState() {
    super.initState();
    _cartoonsFuture = _getCartoons();
    _searchController = TextEditingController();
  }

  Future<List<Cartoon>> _getCartoons() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response = await dio.get('https://api.sampleapis.com/cartoons/cartoons2D');
    List list = jsonDecode(response.data);
    return list.map((cartoon) => Cartoon.fromJson(cartoon)).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Cartoon>>(
        future: _cartoonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Cartoon> cartoons = snapshot.data!;
            return ListView.builder(
  itemCount: cartoons.length,
  itemBuilder: (context, index) {
    final cartoon = cartoons[index];
    return ListTile(
      title: Text(cartoon.title),
      onTap: () {
        if (cartoon.image.isNotEmpty) { // Check if image is not empty
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Image.network(
                  cartoon.image, 
                ),             
              );
            },
          );
        }
      },
    );
  },
);
          }
        },
      ),
    );
  }
}


