import 'package:flutter/material.dart';

class JajarGenjangPage extends StatefulWidget {
  const JajarGenjangPage({super.key});

  @override
  JajarGenjangPageState createState() => JajarGenjangPageState();
}

class JajarGenjangPageState extends State<JajarGenjangPage> {
  final TextEditingController alasController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController sisiMiringController = TextEditingController();
  String result = "Hasil: 0.0";
  final int maxLength = 15;

  void calculateResult(String operation) {
    double? alas = double.tryParse(alasController.text.replaceAll(',', '.'));
    double? tinggi =
        double.tryParse(tinggiController.text.replaceAll(',', '.'));
    double? sisiMiring =
        double.tryParse(sisiMiringController.text.replaceAll(',', '.'));

    if (alas == null || tinggi == null || sisiMiring == null) {
      setState(() {
        result = "Masukkan semua angka dengan benar";
      });
      return;
    }

    setState(() {
      if (operation == 'luas') {
        result = "Luas: ${(alas * tinggi).toStringAsFixed(2)}";
      } else if (operation == 'keliling') {
        result = "Keliling: ${(2 * (alas + sisiMiring)).toStringAsFixed(2)}";
      }
    });
  }

  void clearInput() {
    setState(() {
      alasController.clear();
      tinggiController.clear();
      sisiMiringController.clear();
      result = "Hasil: 0.0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HITUNG JAJAR GENJANG",
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
                        "Masukkan Nilai",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      const SizedBox(height: 15),
                      inputField(alasController, "Alas (luas & keliling)"),
                      const SizedBox(height: 15),
                      inputField(tinggiController, "Tinggi (luas)"),
                      const SizedBox(height: 15),
                      inputField(
                          sisiMiringController, "Sisi Miring (keliling)"),
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
                    "LUAS", Colors.orange, () => calculateResult('luas'))),
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
        border: Border.all(color: const Color(0xFF5B0583)),
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
