import '../entities/user_entity.dart' show MyUserEntity;

export 'user.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  static final empty = MyUser(
      userId: '',
      email: '',
      name: '',
      hasActiveCart: false
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: '',
        email: '',
        name: '',
        hasActiveCart: hasActiveCart
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: '',
        email: '',
        name: '',
        hasActiveCart: entity.hasActiveCart
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }
}