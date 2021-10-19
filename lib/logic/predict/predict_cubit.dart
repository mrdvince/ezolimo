import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'predict_state.dart';

class PredictCubit extends Cubit<PredictState> {
  final ImagePicker _picker = ImagePicker();
  PredictCubit() : super(PredictInitial());

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
}
