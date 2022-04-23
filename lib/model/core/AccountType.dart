class AccountType {
  AccountType({
    required this.id,
    required this.type,
  });

  int id;
  String type;

  factory AccountType.fromJson(Map<String, dynamic> json) => AccountType(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
      };
}
