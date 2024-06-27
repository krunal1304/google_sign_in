
class ApiResponseModel {

  dynamic result;

  ApiResponseModel({
    this.result
  });

  ApiResponseModel.fromJson(Map map)
      : result = map;

}