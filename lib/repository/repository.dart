import '../models/product_model.dart';
import '../service/httpService.dart';

class ShopRepository {
  final HttpService httpService = HttpService();

  ShopRepository();

  Future<List<ProductModel>> fetchProductData() async {
    try {
      var jsonData = await httpService.getData('products', null);
      print(jsonData);
      List<ProductModel> data = ProductModel.fromList(jsonData);
      return data;
    } catch (e) {
      // Handle errors
      return Future.error(e.toString());
    }
  }
}
