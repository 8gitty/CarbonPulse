import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore_service.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() =>
      _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  File? imageFile;
  Uint8List? webImage;

  final unitsController = TextEditingController();

  String estimatedCarbon = "";
  bool isSaved = false;

  final FirestoreService firestoreService =
  FirestoreService();

  Future<void> pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        webImage = await pickedFile.readAsBytes();
      } else {
        imageFile = File(pickedFile.path);
      }

      setState(() {
        estimatedCarbon = "";
        isSaved = false;
      });
    }
  }

  void calculateCarbon() {
    int units =
        int.tryParse(unitsController.text) ?? 0;

    double carbon = units * 0.4;

    setState(() {
      estimatedCarbon =
          carbon.toStringAsFixed(2);
    });
  }

  Future<void> saveToFirebase() async {
    int units =
        int.tryParse(unitsController.text) ?? 0;

    if (units <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid units"),
        ),
      );
      return;
    }

    double carbon = units * 0.4;

    await firestoreService.saveCarbonHistory(
      source: "Bill Scanner",
      carbonScore: carbon,
      electricityUnits: units,
    );

    setState(() {
      estimatedCarbon =
          carbon.toStringAsFixed(2);
      isSaved = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved to Firebase successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Bill Scanner"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.upload),
                label: const Text("Upload Bill"),
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (kIsWeb && webImage != null)
              ClipRRect(
                borderRadius:
                BorderRadius.circular(20),
                child: Image.memory(
                  webImage!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            if (!kIsWeb && imageFile != null)
              ClipRRect(
                borderRadius:
                BorderRadius.circular(20),
                child: Image.file(
                  imageFile!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 25),

            TextField(
              controller: unitsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                "Enter Consumed Units from Bill",
                prefixIcon:
                const Icon(Icons.electric_bolt),
                filled: true,
                fillColor: isDark
                    ? const Color(0xFF1B2A24)
                    : Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateCarbon,
                child: const Text(
                  "Calculate Carbon",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Estimated Carbon Score",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      estimatedCarbon.isEmpty
                          ? "0"
                          : estimatedCarbon,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.orange,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: saveToFirebase,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Save to Firebase",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (isSaved)
              const Text(
                "Saved successfully. Check Analytics page.",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}