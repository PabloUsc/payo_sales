// ignore_for_file: avoid_print

import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/models/sale_product.dart';

class ShoppingCart {
  final Map<Product, int> cart = {};

  bool get isNotEmpty => cart.isNotEmpty;
  bool get isEmpty => cart.isEmpty;

  get entries => cart.entries;

  void addProduct(Product product, {int quantity = 1}) {
    if (cart.containsKey(product)) {
      cart[product] = cart[product]! + quantity;
    } else {
      cart[product] = quantity;
    }
  }

  int? getProductQty(Product product) {
    if(cart.containsKey(product)) {
      return cart[product];
    } else {
      return 0;
    }
  }

  void updateQuantity(Product product, int? quantity) {
    if (!cart.containsKey(product)) addProduct(product);

    if (quantity! > 0) {
      cart[product] = quantity;
    } else {
      cart.remove(product);
    }
  }

  void removeProduct(Product product) {
    cart.remove(product);
  }

  double getTotal() {
    double total = 0.0;
    cart.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  void printCart() {
    if (cart.isEmpty) {
      print("Cart is empty.");
    } else {
      cart.forEach((product, quantity) {
        print("${product.category.name} ${product.name} - Quantity: $quantity - Total: \$${product.price * quantity}");
      });
      print("Total Price: \$${getTotal()}");
    }
  }

  void clearCart() {
    cart.clear();
  }

  Future<void> makeSale(PaymentMethod pMethod) async {
    Sale sale = Sale(paymentMethod: pMethod, total: getTotal(), datetime: DateTime.now(), id: 'Sale_${pMethod.name}_${DateTime.now().toString()}');
    globalBu.addSale(sale);
    cart.forEach((product, quantity) {
      //sale.productsSold.add(product.id);          //Add the product to the sale (not commited)
      SaleProduct sp = SaleProduct(product: product, quantity: quantity, sale: sale.id);
      globalBu.addSaleProduct(sp);     //Add sale product
      globalBu.addSaleProdToSale(sale, sp);
      globalBu.addProductStock(product, quantity * -1);     //Update stock of product
    });
    //globalBu.saleBox.put(sale.id, sale);          //Commit sale with products ids
  }
}