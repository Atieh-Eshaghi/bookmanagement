class Authentication {
  final String username;
  final String name;

  final String id;
  Authentication({required this.username, required this.name , required this.id});

  static Authentication? user;
}
