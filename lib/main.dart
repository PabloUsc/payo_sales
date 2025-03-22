import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/models/product_purchase.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/models/sale_product.dart';
import 'package:payo_sales/utils/box_utils.dart';
import 'package:payo_sales/views/inventory.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:payo_sales/views/sales_view.dart';
import 'package:payo_sales/views/venta.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ProductPurchaseAdapter());
  Hive.registerAdapter(SaleAdapter());
  Hive.registerAdapter(SaleProductAdapter());
  Hive.registerAdapter(ProductCategoryAdapter());
  Hive.registerAdapter(ProviderAdapter());
  Hive.registerAdapter(PaymentMethodAdapter());

  await openHiveBoxes();

  runApp(PayoSalesApp());
}

Future<void> openHiveBoxes() async {
  await Hive.openBox<Product>('products');
  await Hive.openBox<Sale>('sales');
  await Hive.openBox<ProductPurchase>('productpurchases');
  await Hive.openBox<SaleProduct>('saleproducts');
}

final globalBu = BoxUtils();

class PayoSalesApp extends StatelessWidget {
  const PayoSalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 29, 36, 40),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 36, 40),
      appBar: AppBar(
        title: Text(
          'Payo Sales',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        //////////////////////////////////COMMENT BEFORE COMPILING APK//////////////////////////////////
        // actions: [
        //   IconButton(onPressed: () => globalBu.clearAllBoxes(), icon: Icon(Icons.delete_forever))
        // ],
        /////////////////////////////////////////END OF DELETE//////////////////////////////////////////
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuItem(context, Icons.wallet, 'Venta', Venta()),
            _buildMenuItem(
              context,
              Icons.book_rounded,
              'Historial',
              SalesView(),
            ),
            _buildMenuItem(
              context,
              Icons.list_rounded,
              'Inventario',
              Inventory(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget screen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Icon(icon, size: 75, color: Colors.white),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 85, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
            child: Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class VentaScreen extends StatelessWidget {
  const VentaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Venta')),
      body: Center(child: Text('Pantalla de Venta')),
    );
  }
}

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial')),
      body: Center(child: Text('Pantalla de Historial')),
    );
  }
}
