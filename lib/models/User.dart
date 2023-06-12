import 'package:pocket_business/models/Product.dart';

class User {
    User({
        this.name,
        this.objectId,
        this.email,
        this.isAdmin
    });

    String? name;
    String? objectId;
    String? email;
    bool? isAdmin;

    factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"] as String?,
        objectId: json["objectId"] as String?,
        email: json["email"] as String?,
        isAdmin: json["is_admin"]
    );

}
