import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/views/add_product.dart';
import 'package:payo_sales/views/add_stock.dart';
import 'package:payo_sales/views/product_view.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  ProductCategory selectedCategory = ProductCategory.Pin;
  var items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      items = globalBu.getFilteredProductsCat(selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 36, 40),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          'Productos',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children:
                  ProductCategory.values.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ChoiceChip(
                        label: Text(category.name.toUpperCase()),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                            items = globalBu.getFilteredProductsCat(
                              selectedCategory,
                            );
                          });
                        },
                        showCheckmark: false,
                        selectedColor:
                            Colors
                                .deepPurple, //Color.fromARGB(255, 75, 57, 239),
                        backgroundColor: Color.fromARGB(
                          255,
                          29,
                          36,
                          40,
                        ), //Colors.grey[800],
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (_, index) {
              return Card(
                color: Color.fromARGB(255, 20, 24, 27),
                child: ListTile(
                  title: Text(
                    items[index].name!,
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
                        '${items[index].stock} disponibles',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '  \$ ${items[index].price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      Product productView = items[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductView(productShown: productView)));
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      Product stockProd = items[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddStock(stockProd: stockProd)),
                      );
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        elevation: 8,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
      ),
    );
  }
}
