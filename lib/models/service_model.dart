
class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final int durationMinutes;
  final List<String> features;
  final double rating;
  final int reviewCount;
  final List<String> availableProfessionals;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.durationMinutes,
    required this.features,
    required this.rating,
    required this.reviewCount,
    required this.availableProfessionals,
  });
}
