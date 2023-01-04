part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
  
  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserDataState {}

class UserData extends UserDataState {
}

class Error extends UserDataState {}
