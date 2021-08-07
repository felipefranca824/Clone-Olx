import 'package:clone_olx/models/Category.dart';
import 'package:clone_olx/repository/parse_errors.dart';
import 'package:clone_olx/repository/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryRepository {
  

  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

    final response = await queryBuilder.query();

    if(response.success){
      return response.results!.map((e) => Category.fromParse(e)).toList();
    }else{
      throw ParseErrors.getDescription(response.error!.code).toString();
    }
  }
}