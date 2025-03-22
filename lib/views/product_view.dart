import 'package:flutter/material.dart';
import 'package:payo_sales/models/product.dart';

class ProductView extends StatelessWidget {
  final Product productShown;
  final TextStyle prodText = TextStyle(
              color: Colors.white,
              backgroundColor: Color.fromARGB(255, 29, 36, 40),
              fontWeight: FontWeight.w600,
              fontSize: 18
            );
  ProductView({super.key, required this.productShown});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 36, 40),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          productShown.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 25.0,
        children: [
          Text(
            'Category: ${productShown.category.name}',
            style: prodText,            
          ),
          Text(
            'Costo: \$${productShown.cost.toStringAsFixed(2)}',
            style: prodText,            
          ),
          Text(
            'Precio de venta: \$${productShown.price.toStringAsFixed(2)}',
            style: prodText,            
          ),
          Text(
            'Provider: ${productShown.provider.name}',
            style: prodText,            
          ),
          Text(
            'Stock: ${productShown.stock}',
            style: prodText,
          ),
          Text(
            'ID: ${productShown.id}',
            style: prodText,
          ),
        ],
      ),
    );
  }
}
