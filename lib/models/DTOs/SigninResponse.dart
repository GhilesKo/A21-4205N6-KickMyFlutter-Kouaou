class SigninResponse {
  String username;

  SigninResponse(this.username);

  SigninResponse.fromJson(Map<String, dynamic> json)
      : username = json['username'];

  Map<String, dynamic> toJson() => {'username': username};

  @override
  String toString() {
    return username;
  }



}
