import 'package:hive/hive.dart';
import 'package:payo_sales/models/product.dart';
import 'package:payo_sales/models/product_purchase.dart';
import 'package:payo_sales/models/sale.dart';
import 'package:payo_sales/models/sale_product.dart';

class BoxUtils {
  final prodBox = Hive.box<Product>('products');
  final prodPurchBox = Hive.box<ProductPurchase>('productpurchases');
  final saleBox = Hive.box<Sale>('sales');
  final saleProdBox = Hive.box<SaleProduct>('saleproducts');


  Future<void> clearAllBoxes() async {
    prodBox.clear();
    prodPurchBox.clear();
    saleBox.clear();
    saleProdBox.clear();
  }

  ////////// Product functions //////////
  
  Future<void> addProduct(Product product) async {
    await prodBox.put(product.id, product);
  }

  List<Product> getProducts() {
    return prodBox.values.toList().reversed.toList();
  }

  List<Product> getFilteredProductsCat(ProductCategory category) {
    var products = List<Product>.empty(growable: true);
    getProducts()
        .where((product) => product.category == category)
        .forEach((product) => products.add(product));
    return products;
  }

  // Could be deprecated
  Future<void> updateProductStock(String id, int newStock) async {
    Product? product = prodBox.get(id);

    if (product != null) {
      product.stock = newStock;
      prodBox.put(id, product);
    }
  }

  Future<void> addProductStock(Product prod, int newStock) async {
    prod.stock += newStock;
    prodBox.put(prod.id, prod);
  }

  Future<void> deleteProduct(String id) async {
    prodBox.delete(id);
  }

  Future<void> clearProductBox() async {
    prodBox.clear();
  }

  ////////// Product purchase functions //////////
  ///   This model is used to represent a stock purchase, which will also add it to the product's stock
  
  Future<void> addProdPurch(ProductPurchase purch) async {
    addProductStock(purch.product, purch.quantity);
    await prodPurchBox.add(purch);
  }

  ////////// Sales functions //////////

  List<Sale> getSalesTransactions() {
    return saleBox.values.toList();
  }

  Future<void> addSale(Sale sale) async {
    await saleBox.put(sale.id, sale);
  }

  Future<void> addSaleProdToSale(Sale sale, SaleProduct prod) async {
    sale.productsSold.add(prod.id);
    saleBox.put(sale.id, sale);
  }

  Future<void> clearSaleBox() async {
    saleBox.clear();
  }

  ////////// Sale products functions //////////
  
  Future<void> addSaleProduct(SaleProduct saleProd) async {
    await saleProdBox.put(saleProd.id,saleProd);
  }

  List<SaleProduct> getSalesOfProduct(Product prod) {
    var sales = List<SaleProduct>.empty(growable: true);
    saleProdBox.values.toList().reversed.toList()
        .where((saleprod) => saleprod.product == prod)
        .forEach((saleprod) => sales.add(saleprod));
    return sales;
  }

  List<SaleProduct> getProductsOfSale(Sale sale) {
    var products = List<SaleProduct>.empty(growable: true);
    saleProdBox.values.toList().reversed.toList()
        .where((saleprod) => saleprod.sale == sale.id)
        .forEach((saleprod) => products.add(saleprod));
    return products;
  }

  Future<void> clearSaleProductBox() async {
    saleProdBox.clear();
  }
}