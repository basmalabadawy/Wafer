import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wafer/core/services/dio_client.dart';
import '../models/post_model.dart';

class PostsRepo {
  final Dio _dio = DioClient.dio;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// للـ Charity: جلب منشوراته هو
  Future<List<PostModel>> getCharityPosts({int? status}) async {
    final token = await _getToken();
    final response = await _dio.get(
      '/api/v1/charity/charity-needs',
      queryParameters: status != null ? {'status': status} : null,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print('Charity Posts: ${response.data}');
    final List data = response.data['data'] ?? [];
    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  /// للـ Donor: جلب كل المنشورات المتاحة
  Future<List<PostModel>> getPublicPosts() async {
    final token = await _getToken();
    final response = await _dio.get(
      '/api/v1/public/charity-needs',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print('Public Posts: ${response.data}');
    final List data = response.data['data'] ?? [];
    return data.map((e) => PostModel.fromJson(e)).toList();
  }

  Future<void> fulfillPost(String id) async {
    final token = await _getToken();
    await _dio.patch(
      '/api/v1/charity/charity-needs/$id/fulfill',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> applyToPost(String id) async {
    final token = await _getToken();
    await _dio.post(
      '/api/v1/donor-organization/charity-needs/$id/apply',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }


  
}
