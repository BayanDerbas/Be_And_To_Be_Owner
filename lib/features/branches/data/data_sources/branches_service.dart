import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/add_branch_response_model.dart';
import '../models/branches_model.dart';
import '../models/edit_branch_name_model.dart';

part 'branches_service.g.dart';

@RestApi(baseUrl : ApiConstant.baseUrl)
abstract class BranchesService{
  factory BranchesService(Dio dio ,{String baseUrl}) = _BranchesService;

  @GET(ApiConstant.branch)
  Future<BranchesModel> getBranches();

  @POST(ApiConstant.addbranch)
  Future<AddBranchResponseModel> addBranch(@Body() FormData data);

  @POST(ApiConstant.edit_branch_name)
  Future<EditBranchNameModel> edit_branch_name({
  @Query('new_name') required String new_name,
  @Query('branch_id') required int branch_id,
  });
}