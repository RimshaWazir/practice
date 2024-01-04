abstract class ProfileUpdateState {}

class ProfileUpdateInitial extends ProfileUpdateState {}

class ProfileUpdateLoading extends ProfileUpdateState {}

class ProfileUpdateSuccess extends ProfileUpdateState {}

class ProfileUpdateError extends ProfileUpdateState {
  final String error;
  ProfileUpdateError(this.error);
}
