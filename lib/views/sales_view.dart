import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/views/sale_prod_view.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  List<Sale> items = [];

  @override
  void initState() {
    super.initState();
    items = globalBu.getSalesTransactions().reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 36, 40),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          'Historial de Ventas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, index) {
              return Card(
                color: Color.fromARGB(255, 20, 24, 27),
                child: ListTile(
                  title: Text(
                    '${items[index].datetime.day}/${items[index].datetime.month}/${items[index].datetime.year}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[index].paymentMethod.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '  \$${items[index].total.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      Sale saleView = items[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SaleProdView(sale: saleView)));
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
