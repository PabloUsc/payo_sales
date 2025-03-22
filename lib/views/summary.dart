import 'package:flutter/material.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/utils/shopping_cart.dart';

class Summary extends StatefulWidget {
  final ShoppingCart cart;
  const Summary({super.key, required this.cart});

  @override
  // ignore: no_logic_in_create_state
  State<Summary> createState() => _SummaryState(cart: cart);
}

class _SummaryState extends State<Summary> {
  final ShoppingCart cart;
  PaymentMethod _method = PaymentMethod.Efectivo;

  _SummaryState({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 29, 36, 40),
        title: Text(
          'Resumen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //List of products START
          Column(
            children:
                cart.entries.map<Widget>((entry) {
                  final product = entry.key;
                  final quantity = entry.value;
                  return ListTile(
                    title: Text(
                      product.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    tileColor: Color.fromARGB(255, 29, 36, 40),
                    subtitle: Text(
                      '$quantity x \$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '\$${(product.price * quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
          ),
          //List of products END
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Total: \$${cart.getTotal().toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          DropdownButtonFormField(
            value: _method,
            decoration: InputDecoration(
              labelText: 'Método de pago',
              labelStyle: const TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white70),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            dropdownColor: Colors.blueGrey,
            items:
                PaymentMethod.values
                    .map(
                      (paymentMethod) => DropdownMenuItem(
                        value: paymentMethod,
                        child: Text(paymentMethod.name),
                      ),
                    )
                    .toList(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            onChanged: (PaymentMethod? pMethod) {
              setState(() {
                _method = pMethod!;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      cart.makeSale(_method);
                      cart.clearCart();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('La venta ha sido realizada con éxito!'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    'Finalizar venta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
