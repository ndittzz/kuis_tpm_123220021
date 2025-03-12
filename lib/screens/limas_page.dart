import 'package:flutter/material.dart';

class LimasPage extends StatefulWidget {
  const LimasPage({super.key});

  @override
  LimasPageState createState() => LimasPageState();
}

class LimasPageState extends State<LimasPage> {
  final TextEditingController sisiController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  String result = "Hasil: 0.0";
  final int maxLength = 15;

  void calculateResult(String operation) {
    double? sisi = double.tryParse(sisiController.text.replaceAll(',', '.'));
    double? tinggi =
        double.tryParse(tinggiController.text.replaceAll(',', '.'));

    if (sisi == null || tinggi == null) {
      setState(() {
        result = "Masukkan angka dengan benar";
      });
      return;
    }

    setState(() {
      if (operation == 'volume') {
        result = "Volume: ${(1 / 3 * sisi * sisi * tinggi).toStringAsFixed(2)}";
      } else if (operation == 'keliling') {
        result = "Keliling: ${(4 * sisi).toStringAsFixed(2)}";
      }
    });
  }

  void clearInput() {
    setState(() {
      sisiController.clear();
      tinggiController.clear();
      result = "Hasil: 0.0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HITUNG LIMAS",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Masukkan Nilai Sisi dan Tinggi",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(height: 15),
                      inputField(sisiController, "Panjang Sisi"),
                      const SizedBox(height: 15),
                      inputField(tinggiController, "Tinggi"),
                      const SizedBox(height: 15),
                      buttonRow(),
                      const SizedBox(height: 15),
                      resultContainer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      maxLength: maxLength,
    );
  }

  Widget buttonRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: button(
                    "VOLUME", Colors.orange, () => calculateResult('volume'))),
            const SizedBox(width: 10),
            Expanded(
                child: button("KELILING", Colors.blue,
                    () => calculateResult('keliling'))),
          ],
        ),
        const SizedBox(height: 10),
        button("CLEAR", Colors.red, clearInput, isFullWidth: true),
      ],
    );
  }

  Widget button(String text, Color color, VoidCallback onPressed,
      {bool isFullWidth = false}) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget resultContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        result,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
