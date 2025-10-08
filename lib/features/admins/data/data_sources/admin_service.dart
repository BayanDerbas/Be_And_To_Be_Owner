import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:untitled/core/networks/api_constant.dart';
import '../models/admin_model.dart';

part 'admin_service.g.dart';

@RestApi()
abstract class AdminService {
  factory AdminService(Dio dio, {String baseUrl}) = _AdminService;

  @GET("${ApiConstant.get_admins}")
  Future<AdminResponse> get_admins();
}
