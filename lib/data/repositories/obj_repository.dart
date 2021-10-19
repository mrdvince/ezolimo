import '../http/http_client.dart';

class ObjDetectRepository {
  Future<List> getObjPred(token, imageFile) async {
    final rawResponse = await getObjDetPreds(token, imageFile);
    if (rawResponse != '') {
    }
    return [];
  }
}
