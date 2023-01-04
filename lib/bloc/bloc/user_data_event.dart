part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvevnt extends UserDataEvent{
  final List<String> docIds;
  final Future getDocIds;

  const GetDataEvevnt(this.docIds, this.getDocIds);
}
