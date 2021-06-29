part of 'former_ward_cubit.dart';

class FormerWardState {
  final List<FormerWardEntity> formerWards;
  final bool loading;
  final Failure failure;
  final List<String> wards;
  FormerWardState({
    @required this.formerWards,
    this.loading,
    this.failure,
    @required this.wards,
  });

  FormerWardState copyWith({
    List<FormerWardEntity> formerWards,
    bool loading,
    Failure failure,
    List<String> wards,
  }) {
    return FormerWardState(
      formerWards: formerWards ?? this.formerWards,
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      wards: wards ?? this.wards,
    );
  }
}
