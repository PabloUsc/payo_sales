import 'package:flutter/material.dart';
import 'package:payo_sales/main.dart';
import 'package:payo_sales/models/product.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 29, 36, 40),
        title: const Text(
          'Añadir Producto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: const AddProductForm(),
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _addProductKey = GlobalKey<FormState>();
  //final bu = BoxUtils();
  ProductCategory _addCategoryForm = ProductCategory.Pin;
  Provider _addProviderForm = Provider.HoneyPie;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
                key: _addProductKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white), // White text
                      decoration: InputDecoration(
                        labelText: 'Nombre de producto',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      controller: _nameController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Categoría",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children:
                          ProductCategory.values.map((category) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ChoiceChip(
                                label: Text(category.name),
                                selected: _addCategoryForm == category,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _addCategoryForm = category;
                                  });
                                },
                                showCheckmark: false,
                                selectedColor: Colors.deepPurple,
                                backgroundColor: Color.fromARGB(
                                  255,
                                  29,
                                  36,
                                  40,
                                ),
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField(
                      value: _addProviderForm,
                      decoration: InputDecoration(
                        labelText: 'Proveedor',
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
                      items:
                          Provider.values
                              .map(
                                (provider) => DropdownMenuItem(
                                  value: provider,
                                  child: Text(provider.name),
                                ),
                              )
                              .toList(),
                      dropdownColor: Color.fromARGB(255, 29, 36, 40),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      onChanged: (Provider? provider) {
                        setState(() {
                          _addProviderForm = provider!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Costo',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            controller: _costController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el costo';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Precio de Venta',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            controller: _priceController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese el precio de venta';
                              }
                              final parsedValue = double.tryParse(value);
                              if (parsedValue == null) {
                                return 'Ingrese un número válido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                setState(() {
                  if (_addProductKey.currentState!.validate() &&
                      // ignore: unnecessary_null_comparison
                      _addCategoryForm != null &&
                      // ignore: unnecessary_null_comparison
                      _addProviderForm != null) {
                    globalBu.addProduct(
                      Product(
                        name: _nameController.text,
                        cost: double.parse(_costController.text),
                        price: double.parse(_priceController.text),
                        stock: 0,
                        category: _addCategoryForm,
                        provider: _addProviderForm,
                      ),
                    );
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Guardado!')));
                    Navigator.pop(context, true);
                  }
                });
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
