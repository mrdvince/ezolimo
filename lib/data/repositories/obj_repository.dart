import '../http/http_client.dart';
import '../models/res_model.dart';

class ObjDetectRepository {
  getObjPred(token, imageFile) async {
    final rawResponse = await getObjDetPreds(token, imageFile);
    final predictions = predictionsFromJson(rawResponse.toString());
    return predictions;
  }
}
