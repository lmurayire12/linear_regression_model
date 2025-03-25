import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const BostonHousingApp());
}

class BostonHousingApp extends StatelessWidget {
  const BostonHousingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boston Housing Predictor',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: const PredictionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  PredictionPageState createState() => PredictionPageState();
}

class PredictionPageState extends State<PredictionPage> {
  final Map<String, TextEditingController> controllers = {
    'crim': TextEditingController(),
    'zn': TextEditingController(),
    'indus': TextEditingController(),
    'rm': TextEditingController(),
    'age': TextEditingController(),
    'dis': TextEditingController(),
    'rad': TextEditingController(),
    'tax': TextEditingController(),
    'ptratio': TextEditingController(),
    'lstat': TextEditingController(),
  };

  String result = '';
  bool isLoading = false;

  Future<void> predict() async {
    final apiUrl = 'https://bostonhousing-wo52.onrender.com/predict';

    void showResultDialog(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            title: const Text("Prediction Result",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(
              message,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }

    final inputData = {
      for (var entry in controllers.entries)
        entry.key: double.tryParse(entry.value.text)
    };

    if (inputData.containsValue(null)) {
      showResultDialog("❗ Please enter valid numbers in all fields.");

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inputData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        showResultDialog("🏠 Predicted Price: \$${data['predicted_price']}");
      } else {
        showResultDialog("❌ Prediction failed. Please check your input.");
      }
    } catch (e) {
      setState(() {
        result = "🚨 Error connecting to the API: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextField(String key, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controllers[key],
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.edit, color: Colors.white),
          hintText: hint,
          labelText: key.toUpperCase(),
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldHints = {
      'crim': 'Crime rate (e.g. 0.1)',
      'zn': 'Residential land zone (%)',
      'indus': 'Industrial area proportion',
      'rm': 'Avg number of rooms (e.g. 6.5)',
      'age': 'Building age (%)',
      'dis': 'Distance to city (e.g. 5.0)',
      'rad': 'Highway accessibility index',
      'tax': 'Property tax (per \$10,000)',
      'ptratio': 'Pupil-teacher ratio',
      'lstat': 'Lower status % (e.g. 12.5)',
    };

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/house.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withAlpha(128)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "🏡 Boston Housing Price Predictor",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter house data below and tap 'Predict' to estimate price",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...controllers.keys
                      .map((key) => buildTextField(key, fieldHints[key]!)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : predict,
                    icon: const Icon(Icons.analytics),
                    label: const Text("Predict"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // if (result.isNotEmpty)
                  //   Card(
                  //     color: Colors.white70,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(16.0),
                  //       child: Text(
                  //         result,
                  //         style: const TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.black87),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
