part of 'addEdit_bloc.dart';

abstract class AddEditEvent extends Equatable {
  const AddEditEvent();

  @override
  List<Object> get props => [];
}

class AddEditPasswordLength extends AddEditEvent {
  final double length;

  const AddEditPasswordLength({@required this.length});
}
