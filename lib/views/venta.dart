import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/utils/shopping_cart.dart';
import 'package:payo_sales/views/summary.dart';

class Venta extends StatefulWidget {
  const Venta({super.key});

  @override
  State<Venta> createState() => _VentaState();
}

class _VentaState extends State<Venta> {
  ShoppingCart cart = ShoppingCart();
  ProductCategory saleCategory = ProductCategory.Pin;
  List<Product> items = [];

  void resetItems() {
    items = globalBu.getFilteredProductsCat(saleCategory);
    items.removeWhere((prod) => prod.stock == 0);
  }

  @override
  void initState() {
    super.initState();
    resetItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          'Venta',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _navigateAndRefresh(MaterialPageRoute(builder: (context) => Summary(cart: cart,)));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: Text('\$${cart.getTotal().toStringAsFixed(2)}'),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 29, 36, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                ),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return GridTile(
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(255, 20, 24, 27),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 6,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            items[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            items[index].provider.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '\$${items[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${items[index].stock} disponibles',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed:
                                    cart.getProductQty(items[index]) == 0
                                        ? null
                                        : () {
                                          setState(() {
                                            cart.updateQuantity(
                                              items[index],
                                              cart.getProductQty(
                                                    items[index],
                                                  )! -
                                                  1,
                                            );
                                          });
                                        },
                                icon: Icon(
                                  Icons.remove,
                                  color:
                                      cart.getProductQty(items[index]) == 0
                                          ? Color.fromARGB(255, 20, 24, 27)
                                          : Colors.white70,
                                ),
                              ),
                              Text(
                                '${cart.getProductQty(items[index])}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    cart.getProductQty(items[index]) ==
                                            items[index].stock
                                        ? null
                                        : () {
                                          setState(() {
                                            cart.updateQuantity(
                                              items[index],
                                              cart.getProductQty(
                                                    items[index],
                                                  )! +
                                                  1,
                                            );
                                          });
                                        },
                                icon: Icon(
                                  Icons.add,
                                  color:
                                      cart.getProductQty(items[index]) ==
                                              items[index].stock
                                          ? Color.fromARGB(255, 20, 24, 27)
                                          : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    ProductCategory.values.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ChoiceChip(
                          label: Text(category.name.toUpperCase()),
                          selected: saleCategory == category,
                          onSelected: (bool selected) {
                            setState(() {
                              saleCategory = category;
                              resetItems();
                            });
                          },
                          showCheckmark: false,
                          selectedColor: Colors.deepPurple,
                          backgroundColor: Color.fromARGB(255, 29, 36, 40),
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _navigateAndRefresh(MaterialPageRoute route) async {
    final result = await Navigator.push(context, route);
    if (result == null) return;
    if (result) {
      setState(() {
        resetItems();
      });
    }
  }
}
