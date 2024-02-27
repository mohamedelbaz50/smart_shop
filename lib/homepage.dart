import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class ProductModel {
  final String name;
  final String price;
  final String barcode;

  ProductModel(
      {required this.name, required this.price, required this.barcode});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'barcode': barcode,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      barcode: json['barcode'] ?? '',
    );
  }
}*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _barcode = "";
  Map<String, dynamic>? _ProductModel; // Initialize with null value

  Future<void> _scanBarcode() async {
    try {
      final barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Annuler',
        true,
        ScanMode.BARCODE,
      );
      setState(() {});
      _barcode = barcodeResult;
      getData(barcodeResult: barcodeResult);
    } catch (e) {
      // Handle error
    }
  }

  void getData({required String barcodeResult}) {
    var result = FirebaseFirestore.instance
        .collection('produits')
        .doc(barcodeResult)
        .get();
    result.then((value) {
      setState(() {
        _ProductModel = value.data();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Barcode: $_barcode'),
            SizedBox(height: 16),
            if (_ProductModel != null)
              Column(
                children: [
                  Text('${_ProductModel!['name']!}'), // Add null check
                  Text('${_ProductModel!['price']!}'), // Add null check
                  Text('${_ProductModel!['barcode']!}'), // Add null check
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarcode,
        tooltip: 'Scan Barcode',
        child: Icon(Icons.qr_code),
      ),
    );
  }
}
