import 'package:pocket_business/models/Product.dart';

class Warehouse {
    Warehouse({
        this.name,
        this.objectId
    });

    String? name;
    String? objectId;

    factory Warehouse.fromMap(Map<String, dynamic> json) => Warehouse(
        name: json["name"] as String?,
        objectId: json["objectId"] as String?
    );

}
