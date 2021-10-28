import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ezolimo/data/repositories/gpt_repository.dart';

import '../storage.dart';

part 'gpt_state.dart';

class GptCubit extends Cubit<GptState> {
  GptCubit({required this.gptRepository}) : super(GptInitial());
  final GptRepository gptRepository;

  fetchAbout(String prediction) async {
    var token = await _getToken();
    final pathogenString = 'What is $prediction ?';
    await gptRepository
        .getPathogen(token, pathogenString)
        .then((aboutPathogen) {
      emit(GptAboutDoneState(aboutPathogen));
    });
  }
 
}

// get token
Future<String> _getToken() async {
  return await Storage().secureStorage.read(key: 'access_token') ?? '';
}
