class UserInfo {
  String nickname;
  String avatar;

  UserInfo({this.nickname = '',this.avatar = ''});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(nickname: json['nickname'] ?? '',avatar: json['avatar'] ?? '');
  }
}
