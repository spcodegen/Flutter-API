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
}
