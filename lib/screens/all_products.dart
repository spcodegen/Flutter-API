import 'package:api/api/api_service.dart';
import 'package:api/model/product_model.dart';
import 'package:api/screens/add_product.dart';
import 'package:api/screens/single_product.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProduct(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Product>>(
          future: apiService.fetchAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error :${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No products found"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Product product = snapshot.data![index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text("\$${product.price}"),
                      leading: Image.network(
                        product.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SingleProduct(productId: product.id!),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
