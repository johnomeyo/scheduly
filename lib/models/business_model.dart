// lib/models/business_model.dart
import 'service_model.dart'; // Import ServiceModel
import 'review_model.dart'; // Import ReviewModel

class BusinessModel {
  final String id; // Unique identifier
  final String name;
  final String tagline;
  final String location;
  final String? imageUrl; // Optional image URL for hero/avatar
  final double rating;
  final int reviewCount;
  final String about; // About Us text
  final List<String> features; // List of feature strings (e.g., 'Open Daily')
  final List<ServiceModel> services;
  final List<ReviewModel> reviews;

  BusinessModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.location,
    this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.about,
    required this.features,
    required this.services,
    required this.reviews,
  });

  // Factory constructor to create from JSON/Map
  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] as String,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      about: json['about'] as String,
      features: List<String>.from(json['features'] as List), // Assuming features is a List of strings
      services: (json['services'] as List)
          .map((serviceJson) => ServiceModel.fromJson(serviceJson as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List)
          .map((reviewJson) => ReviewModel.fromJson(reviewJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert to JSON/Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'location': location,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'about': about,
      'features': features,
      'services': services.map((service) => service.toJson()).toList(),
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}