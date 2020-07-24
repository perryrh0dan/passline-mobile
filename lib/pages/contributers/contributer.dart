class Contributer {
  final String login;
  final int id;
  final String avatarUrl;

  Contributer({this.login, this.id, this.avatarUrl});

  factory Contributer.fromJson(Map<String, dynamic> json) {
    return Contributer(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url']
    );
  }
}