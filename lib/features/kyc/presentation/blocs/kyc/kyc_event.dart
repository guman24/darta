part of 'kyc_bloc.dart';

abstract class KycEvent extends Equatable {
  const KycEvent();

  @override
  List<Object> get props => [];
}

class PerformKycVerification extends KycEvent {
  final Map<String, dynamic> data;
  final List<DocumentEntity> files;
  final String userPhotoUrl;
  PerformKycVerification({
    @required this.data,
    @required this.files,
    @required this.userPhotoUrl,
  });
}

class KycUserRequestEvent extends KycEvent {}
