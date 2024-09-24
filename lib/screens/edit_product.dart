import 'dart:ffi';

import 'package:api/api/api_service.dart';
import 'package:api/model/product_model.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Product product;

  const EditProduct({
    super.key,
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late String title;
  late double price;
  late String description;
  late String image;
  late String category;

  @override
  void initState() {
    super.initState();
    title = widget.product.title;
    price = widget.product.price;
    description = widget.product.description;
    image = widget.product.image;
    category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  price = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  image = value!;
                },
              ),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  category = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Product updatedProdcut = Product(
                        title: title,
                        price: price,
                        description: description,
                        image: image,
                        category: category);

                    try {
                      apiService.updatedProduct(
                          widget.product.id!, updatedProdcut);
                      Navigator.pop(context);
                    } catch (error) {
                      print(error.toString());
                    }
                  }
                },
                child: const Text("Updated Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
