// lib/models/review_model.dart
class ReviewModel {
  final String id; // Unique identifier
  final String reviewerName;
  final double rating;
  final String comment;
  final DateTime date; // Use DateTime for date

  ReviewModel({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  // Factory constructor to create from JSON/Map
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      reviewerName: json['reviewerName'] as String,
      rating: (json['rating'] as num).toDouble(), // Handle potential int/double from JSON
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String), // Assuming date is a parsable string (e.g., ISO 8601)
    );
  }

  // Method to convert to JSON/Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewerName': reviewerName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(), // Store date as ISO 8601 string
    };
  }
}