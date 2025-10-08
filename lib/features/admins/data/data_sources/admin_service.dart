import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:untitled/core/networks/api_constant.dart';
import '../models/add_admin_model.dart';
import '../models/admin_model.dart';

part 'admin_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class AdminService {
  factory AdminService(Dio dio, {String baseUrl}) = _AdminService;

  @GET("${ApiConstant.get_admins}")
  Future<AdminResponse> get_admins();

  @POST("${ApiConstant.add_admin}")
  Future<AddAdminModel> add_admin(
      @Query('fullname')  String fullname,
      @Query('password') String password,
      @Query('phonenumber') String phonenumber,
      @Query('branch_id') int branch_id,
      );
}
