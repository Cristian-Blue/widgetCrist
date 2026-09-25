import 'package:contador/model/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio = Dio();
  Future<List<ProductModel>> getProduct() async {
    final response = await _dio.get('https://fakestoreapi.com/products');
    print('adfadfadfadsfadfadfadfadfa');
    print(response.statusCode);
    print('adfadfadfadsfadfadfadfadfa');
    if (response.statusCode != 200) {
      return [];
    }
    final List<dynamic> data = response.data;
    print('======================');
    print(data);
    print('======================');
    return data.map((element) => ProductModel.fromJson(element)).toList();
  }
}
