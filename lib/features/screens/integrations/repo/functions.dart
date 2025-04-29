// import 'package:dio/dio.dart';
// import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
// import 'package:smart_cleaning_application/core/networking/dio_helper/dio_helper.dart';
// import 'package:smart_cleaning_application/features/screens/integrations/data/models/role_model.dart';

// class FunctionsDataRepo {
//   Future<List<RoleModel>> getRole() async {
//     try {
//       final Response response =
//           await DioHelper.getData(url: ApiConstants.rolesUrl);

//       final List<dynamic> data = response.data['data'] ?? [];

//       return data.map((e) => RoleModel.fromJson(e)).toList();
//     } catch (error) {
//       return [];
//     }
//   }
// }
