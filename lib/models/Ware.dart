import 'package:pocket_business/models/Product.dart';

class Ware {
    Ware({
        this.objectId
    });

    String? objectId;

    factory Ware.fromMap(Map<String, dynamic> json) => Ware(
        objectId: json["objectId"] as String?
    );

}
