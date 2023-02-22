import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<List<ParseObject>> getGalleryList() async {
  QueryBuilder<ParseObject> queryPublisher =
      QueryBuilder<ParseObject>(ParseObject('Gallery'))
        ..orderByAscending('createdAt');
  final ParseResponse apiResponse = await queryPublisher.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}
