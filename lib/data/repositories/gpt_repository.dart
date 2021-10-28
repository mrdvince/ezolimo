import '../http/http_client.dart';

class GptRepository {
  Future<String> getPathogen(String token, question) async {
    final aboutResponse = await getGptDetails(token, question);
    return aboutResponse;
  }

  getPathogenWithLog(String token, String question, String chatLog) async {
    final response = await getGptDetailsWithLog(token, question, chatLog);
    print(response);
    return response;
  }
}
