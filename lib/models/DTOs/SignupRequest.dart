 class SignupRequest {

   String username;
   String password;

   SignupRequest(this.username,this.password);

   Map<String, dynamic> toJson() {
      return {
         'username': username,
         'password': password,
      };
   }


}