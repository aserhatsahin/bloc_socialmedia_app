part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user; //stores authenticated users information

  const AuthenticationState._({
    //._ allows this constructor to reached only inside of this class
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  ///No information about the [AuthenticationStatus] of the current user
  const AuthenticationState.unknown() : this._();

  ///user is [authenticated].

  ///a [MyUser] property representing the current [authenticated] user.
  const AuthenticationState.authenticated(User user)
    : this._(status: AuthenticationStatus.authenticated, user: user);

  ///Current user is [unauthenticated].
  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  List<Object?> get props => [status, user];
}
