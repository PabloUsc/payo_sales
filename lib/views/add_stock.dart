import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/models/product_purchase.dart';
//import 'package:payo_sales/utils/box_utils.dart';

class AddStock extends StatelessWidget {
  final Product stockProd;
  const AddStock({super.key, required this.stockProd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 29, 36, 40),
        title: const Text(
          "Añadir Stock",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: AddStockForm(stockProd: stockProd),
    );
  }
}

class AddStockForm extends StatefulWidget {
  final Product stockProd;
  const AddStockForm({super.key, required this.stockProd});

  @override
  // ignore: no_logic_in_create_state
  State<AddStockForm> createState() => _AddStockFormState(stockProd: stockProd);
}

class _AddStockFormState extends State<AddStockForm> {
  final GlobalKey<FormState> _addStockKey = GlobalKey<FormState>();
  final Product stockProd;
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();

  _AddStockFormState({required this.stockProd});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 29, 36, 40), // Background color
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _addStockKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stockProd.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _qtyController,
                      decoration: InputDecoration(
                        labelText: 'Cantidad',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la cantidad';
                        }
                        final parsedValue = int.tryParse(value);
                        if (parsedValue == null) {
                          return 'Ingrese un número válido';
                        }
                        if (parsedValue <= 0) {
                          return 'Ingrese una cantidad mayor a 0';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _totalCostController,
                      decoration: InputDecoration(
                        labelText: 'Costo total',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el costo total';
                        }
                        final parsedValue = double.tryParse(value);
                        if (parsedValue == null) {
                          return 'Ingrese un número válido';
                        }
                        if (parsedValue <= 0) {
                          return 'Ingrese un costo mayor a 0';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_addStockKey.currentState!.validate()) {
                  setState(() {
                    globalBu.addProdPurch(
                      ProductPurchase(
                        product: stockProd,
                        quantity: int.parse(_qtyController.text),
                        totalCost: double.parse(_totalCostController.text),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Stock de ${stockProd.category.name.toLowerCase()} de ${stockProd.name} actualizado!',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Añadir', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
