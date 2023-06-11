import 'package:pocket_business/models/Ware.dart';

class Product {
    Product({
        this.id,
        this.name,
        this.cost,
        this.group,
        this.location,
        this.company,
        this.quantity,
        this.image,
        this.description,
    });
    String? id;
    String? name;
    int? cost;
    String? group;
    Ware? location;
    String? company;
    int? quantity;
    String? image;
    String? description;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["objectId"] as String?,
        name: json["product_name"] as String?,
        cost: json["product_price"] as int,
        group: json["group"] as String?,
        location: Ware.fromMap(json["ware"]),
        company: json["company"] as String?,
        quantity: json["product_quantity"] as int?,
        image: json["image"] as String?,
        description: json["product_description"] as String?,
    );

}
