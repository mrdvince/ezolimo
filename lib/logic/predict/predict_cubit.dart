import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/obj_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../storage.dart';

part 'predict_state.dart';

class PredictCubit extends Cubit<PredictState> {
  final ImagePicker _picker = ImagePicker();
  PredictCubit({required this.objDetectRepository}) : super(PredictInitial());

  final ObjDetectRepository objDetectRepository;

  void getImage({required ImageSource source}) async {
    emit(NullIfyImage());

    final XFile? image =
        await _picker.pickImage(source: source, maxWidth: 400.0);

    if (image != null) {
      emit(ImageSelectedState(image.path));
    } else {
      emit(ImageErrorState());
    }
  }

  void objDetectImage(Object? imageFile) async {
    var token = await _getToken();
    objDetectRepository.getObjPred(token, imageFile.toString());
  }
}

// get token
Future<String> _getToken() async {
  return await Storage().secureStorage.read(key: 'access_token') ?? '';
}
