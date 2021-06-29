part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerEmpty extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final File image;

  ImagePickerSuccess({this.image});

  @override
  List<Object> get props => [image];
}
