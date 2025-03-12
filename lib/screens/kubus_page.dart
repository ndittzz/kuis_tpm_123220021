import 'package:flutter/material.dart';

class KubusPage extends StatefulWidget {
  const KubusPage({super.key});

  @override
  KubusPageState createState() => KubusPageState();
}

class KubusPageState extends State<KubusPage> {
  final TextEditingController sisiController = TextEditingController();
  String result = "Hasil: 0.0";
  final int maxLength = 15;

  void calculateResult(String operation) {
    double? sisi = double.tryParse(sisiController.text.replaceAll(',', '.'));

    if (sisi == null) {
      setState(() {
        result = "Masukkan angka dengan benar";
      });
      return;
    }

    setState(() {
      if (operation == 'volume') {
        result = "Volume: ${(sisi * sisi * sisi).toStringAsFixed(2)}";
      } else if (operation == 'keliling') {
        result = "Keliling: ${(12 * sisi).toStringAsFixed(2)}";
      }
    });
  }

  void clearInput() {
    setState(() {
      sisiController.clear();
      result = "Hasil: 0.0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HITUNG KUBUS",
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
                        "Masukkan Nilai Sisi",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(height: 15),
                      inputField(sisiController, "Panjang Sisi"),
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
        border: Border.all(color: Colors.blue),
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
