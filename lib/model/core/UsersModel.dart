import 'AccountType.dart';

class UsersModel {
  UsersModel({
    required this.id,
    required this.names,
    required this.email,
    required this.password,
    required this.accountTypeId,
    this.accountType,
  });

  int id;
  String names;
  String email;
  String password;
  int accountTypeId;
  AccountType? accountType;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"] == null ? null : json["id"],
        names: json["names"] == null ? null : json["names"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        accountTypeId:
            json["accountTypeId"] == null ? null : json["accountTypeId"],
        accountType: json["accountType"] == null
            ? null
            : AccountType.fromJson(json["accountType"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "names": names == null ? null : names,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "accountTypeId": accountTypeId == null ? null : accountTypeId,
        "accountType": accountType == null ? null : accountType?.toJson(),
      };
}
