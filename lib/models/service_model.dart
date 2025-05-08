class ServiceModel {
  final String id; 
  final String name;
  final String price;
  final String duration;
  final String description;

  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
  });

  // Factory constructor to create from JSON/Map (optional, but good practice)
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      duration: json['duration'] as String,
      description: json['description'] as String,
    );
  }

  // Method to convert to JSON/Map (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'duration': duration,
      'description': description,
    };
  }
}