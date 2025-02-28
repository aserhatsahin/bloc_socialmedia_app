part of 'my_user_bloc.dart';

enum MyUserStatus { success, loading, failure }

class MyUserState extends Equatable {
  final MyUser? user;
  final MyUserStatus status;

  const MyUserState._({this.status = MyUserStatus.loading, this.user});

  const MyUserState.loading() : this._();

  const MyUserState.failure() : this._(status: MyUserStatus.failure);

  const MyUserState.success(MyUser user)
    : this._(status: MyUserStatus.success, user: user);

  @override
  List<Object?> get props => [status, user];
}
