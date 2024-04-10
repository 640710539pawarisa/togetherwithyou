import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:togetherwithyou/apicartoon.dart';

void main() {
  runApp(MaterialApp(
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget { 
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Hello',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 24,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/first.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: Text(
                  'เพื่อคุณ ลองคลิกดูสิ',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<String> imagePaths;
  late int randomIndex;

  @override
  void initState() {
    super.initState();
    imagePaths = [
      'assets/images/1.jpg',
      'assets/images/2.jpg',
      'assets/images/3.jpg',
      'assets/images/4.jpg',
      'assets/images/5.jpg',
      'assets/images/6.jpg',
      'assets/images/7.jpg',
      'assets/images/8.jpg',
      'assets/images/9.jpg',
      'assets/images/10.jpg',
      'assets/images/11.jpg',
      'assets/images/12.jpg',
      'assets/images/13.jpg',
      'assets/images/14.jpg',
      'assets/images/15.jpg',
      'assets/images/16.jpg',
      'assets/images/17.jpg',
      'assets/images/18.jpg',
      'assets/images/19.jpg',
      'assets/images/20.jpg',
      'assets/images/21.jpg',
      'assets/images/22.jpg',
      'assets/images/23.jpg',
      'assets/images/24.jpg',
    ];
    randomIndex = Random().nextInt(imagePaths.length);
  }

  void _changeImage() {
    setState(() {
      randomIndex = Random().nextInt(imagePaths.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '2Getherwithyu',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: _buildPageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeImage,
        tooltip: 'Random Image',
        child: Icon(Icons.autorenew),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildPageBody() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/back.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 400.0,
                height: 400.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width:8.0),
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[randomIndex]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'with you<3',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ApiPage()),
                  );
                },
                child: Text('ถ้าเครียดๆมีการ์ตูนแนะนำนะลองคลิกดูสิ', style: TextStyle(fontSize: 24, color: Colors.blueGrey)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key});

  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Future<List<Cartoons>> apiResponse;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartoons',
        style: TextStyle(fontSize: 24.0,color: Colors.deepPurple
        ),
        ),
          backgroundColor: Colors.lightBlueAccent,
      ),
      
      body: Container(
        color: Colors.lightBlueAccent,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CartoonListPage (),
            ),
          ),
        ],
      ),
      ),
    );
  } 
}

class Cartoons {
  final String name;

  Cartoons({required this.name});

  factory Cartoons.fromJson(Map<String, dynamic> json) {
    return Cartoons(
      name: json['name'] ?? '',
    );
  }
}
