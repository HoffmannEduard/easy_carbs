class MealImageActionState {
  final bool isBusy;
  final String? error;

  const MealImageActionState({
    this.isBusy = false,
    this.error,
  });

  MealImageActionState copyWith({
    bool? isBusy,
    String? error,
  }) {
    return MealImageActionState(
      isBusy: isBusy ?? this.isBusy,
      error: error,
    );
  }
}
