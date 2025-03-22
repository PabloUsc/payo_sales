import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/models/sale_product.dart';

class SaleProdView extends StatefulWidget {
  final Sale sale;
  const SaleProdView({super.key, required this.sale});

  @override
  // ignore: no_logic_in_create_state
  State<SaleProdView> createState() => _SaleProdViewState(sale: sale);
}

class _SaleProdViewState extends State<SaleProdView> {
  final Sale sale;
  List<SaleProduct> items = List<SaleProduct>.empty(growable: true);

  _SaleProdViewState({required this.sale});

  @override
  void initState() {
    super.initState();
    setState(() {
      items = globalBu.getProductsOfSale(sale);
    });
    print(sale.productsSold);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 36, 40),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          'Venta del ${sale.datetime.day}/${sale.datetime.month}/${sale.datetime.year}',
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
                    '${items[index].product.category.name} - ${items[index].product.name}',
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
                        '${items[index].quantity.toString()} vendidos',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '\$${(items[index].unitPrice *
                                items[index].quantity).toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                sale.paymentMethod.name,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                'Total: \$${sale.total.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
