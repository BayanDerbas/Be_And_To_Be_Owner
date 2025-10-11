import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/networks/api_constant.dart';
import '../models/add_branch_response_model.dart';
import '../models/branches_model.dart';

part 'branches_service.g.dart';

@RestApi(baseUrl : ApiConstant.baseUrl)
abstract class BranchesService{
  factory BranchesService(Dio dio ,{String baseUrl}) = _BranchesService;

  @GET(ApiConstant.branch)
  Future<BranchesModel> getBranches();

  @POST(ApiConstant.addbranch)
  Future<AddBranchResponseModel> addBranch(@Body() FormData data);

// @POST(ApiConstant.addbranch)
  // Future<AddBranchResponseModel> addBranch({@Body() required FormData data});
}