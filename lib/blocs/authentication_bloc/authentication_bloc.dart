import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required UserRepository myUserRepository})
    : userRepository = myUserRepository,
      super(AuthenticationState.unknown()) {
    /// [userRepository.user] is a stream that listens to Firebase Authentication state changes.
    /// It emits a [User] object when a user logs in and emits `null` when a user logs out.
    ///
    /// When the authentication state changes, the [add(AuthenticationUserChanged(authUser))]
    /// method is called to dispatch a new event to the Bloc.
    /// This event updates the authentication state accordingly.
    _userSubscription = userRepository.user.listen((authUser) {
      add(AuthenticationUserChanged(authUser));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(AuthenticationState.unauthenticated());
      }
    });
  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
