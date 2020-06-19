 
part of 'credential_bloc.dart';

abstract class CredentialEvent extends Equatable {
  const CredentialEvent();

  @override
  List<Object> get props => [];
}

class CredentialStarted extends CredentialEvent{}

class CredentialDecrypt extends CredentialEvent{
  final Credential credential;

  const CredentialDecrypt({@required this.credential});
}