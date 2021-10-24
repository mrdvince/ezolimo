import '../models/res_model.dart';

import '../http/http_client.dart';

class ObjDetectRepository {
  getObjPred(token, imageFile) async {
    final rawResponse = await getObjDetPreds(token, imageFile);
    final Map<String, dynamic> mmap = {...rawResponse[0], ...rawResponse[1]};
    final predictions = Predictions.fromJson(mmap);
    return predictions;
  }
}
