//ResultPage.dart

import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String resultText; // Result text obtained from AI model

  ResultsScreen({required this.resultText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Буцах'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No previous page!")),
              );
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned (
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/result.png',
              fit: BoxFit.contain,
            ),
          ),
          
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: Image.asset(
              
              'assets/images/white_dragon.png',
              
                width: 150,
                height: 140,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Text(
                resultText,
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
