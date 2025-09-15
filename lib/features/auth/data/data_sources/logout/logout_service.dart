import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/networks/api_constant.dart';
import '../../models/logout/logout_model.dart';

part 'logout_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class LogoutService {
  factory LogoutService(Dio dio, {String baseUrl}) = _LogoutService;

  @POST(ApiConstant.logout)
  Future<LogoutModel> logout(@Header("Authorization") String bearerToken);
}
