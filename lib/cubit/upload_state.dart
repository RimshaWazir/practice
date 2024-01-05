abstract class DummyState {}

class DummyInitial extends DummyState {}

class DummyLoading extends DummyState {}

class DummyLoaded extends DummyState {}

class DummyError extends DummyState {
  final String? error;

  DummyError({this.error});
}
