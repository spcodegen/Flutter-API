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
}
