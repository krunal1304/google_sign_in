

class SignInResponseModel {

  String? firstName;
  String? lastName;
  String? gender;
  String? username;
  String? password;
  String? birthDate;

  SignInResponseModel();

  SignInResponseModel.fromJson(dynamic json) {

    if (json != null) {
      if (json["firstName"] != null) {
        firstName = json["firstName"];
      }

      if (json["lastName"] != null) {
        lastName = json["lastName"];
      }

      if (json["gender"] != null) {
        gender = json["gender"];
      }

      if (json["username"] != null) {
        username = json["username"];
      }

      if (json["password"] != null) {
        password = json["password"];
      }

      if (json["birthDate"] != null) {
        birthDate = json["birthDate"];
      }

    }

  }

}
