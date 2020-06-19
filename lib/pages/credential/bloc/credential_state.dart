part of 'credential_bloc.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();

  @override
  List<Object> get props => [];
}

class CredentialInitial extends CredentialState {}

class CredentialDecryptionSuccess extends CredentialState {
  final String password;

  const CredentialDecryptionSuccess({@required this.password});  
}

class CredentialDecryptionError extends CredentialState {
  final String error;

  const CredentialDecryptionError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DecryptionFailure { error: $error }';
}