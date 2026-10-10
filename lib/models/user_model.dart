class UserModel {
  final String name;
  final String username;
  final String image;

  bool isFollowing;
  int followers;

  UserModel({
    required this.name,
    required this.username,
    required this.image,
    this.isFollowing = false,
    this.followers = 1200,
  });
}