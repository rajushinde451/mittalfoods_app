
class Product {
  int id;
  String name;

  Product(
      this.id,
      this.name
      );

    factory Product.fromJson(Map<String, dynamic> json) {
      return Product(
              json['id'],
              json['product_name'],
            );
  }
}
