import 'dart:convert';

import 'package:api/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //Fetch all product from the API
  Future<List<Product>> fetchAllProducts() async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        List<dynamic> responceData = json.decode(responce.body);
        List<Product> products = responceData.map((json) {
          return Product.fromJson(json);
        }).toList();

        return products;
      } else {
        print(
            "Faild to fetch the proucts the status code:${responce.statusCode}");
        throw Exception("Fails to fetch products");
      }
    } catch (error) {
      print("Error:$error");
      throw Exception("Faild to fetch products");
    }
  }

  //Fetch a single product from the API
  Future<Product> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        //json object convert to dart object
        Product product = Product.fromJson(json.decode(responce.body));
        return product;
      } else {
        print("Failed to fetch product. Status code: ${responce.statusCode}");
        throw Exception("Failed to fetch Product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch Product");
    }
  }

  //Add a product to the API

  Future<Product> addProduct(Product product) async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final responce = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      print("responce status code:${responce.statusCode}");

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        print("responce:${responce.body}");
        Product newProduct = Product.fromJson(json.decode(responce.body));
        return newProduct;
      } else {
        print("Failed to add prodcut. Status code: ${responce.statusCode}");
        print("Response body: ${responce.body}");
        throw Exception("Failed to add prodcut");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to add product");
    }
  }

  // Update a product in the API

  Future<Product> updatedProduct(int id, Product product) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final responce = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      if (responce.statusCode == 200) {
        print("responce:${responce.body}");
        Product updatedProduct = Product.fromJson(json.decode(responce.body));
        return updatedProduct;
      } else {
        print("Failed to update product. Status code: ${responce.statusCode}");
        throw Exception("Failed to update product");
      }
    } catch (error) {
      print("Eroor: $error");
      throw Exception("Failed to update product");
    }
  }

  //Delete a product from the API
  Future<void> deleteProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final responce = await http.delete(Uri.parse(url));

      if (responce.statusCode == 200) {
        print("Response body: ${responce.body}");
        print("Response status code: ${responce.statusCode}");
      } else {
        print("Failed to update product. Status code: ${responce.statusCode}");
        throw Exception("Failed to update product");
      }
    } catch (error) {
      print("Error : $error");
      throw Exception("Failed to delete product");
    }
  }
}
