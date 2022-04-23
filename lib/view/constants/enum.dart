enum dbOperations {
  get,
  create,
  update,
  getAll,
}

enum UserDetails {
  userId,
  userName,
  userEmail,
  userPhoneNumber,
  fullName,
  dateOfBirth,
  imagePath
}
enum AccessTokenEnum { token, refreshToken }
enum UserStation { stationID }

String getEnumValue(var enumValue) {
  String data =
      enumValue.toString().substring(enumValue.toString().indexOf('.') + 1);
  return data;
}
