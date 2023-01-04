import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<UserDataEvent>((event, emit) {
      if (event is GetDataEvevnt) {
        emit(UserData());
        Future getDocIds() async {
          await FirebaseFirestore.instance
              .collection('users')
              .get()
              .then((snapshot) => snapshot.docs.forEach((element) {
                    print(element.reference);
                    event.docIds.add(element.reference.id);
                  }));
        }
      }
    });
  }
}
