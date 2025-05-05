
// Model classes
class Booking {
  final String id;
  final String serviceName;
  final String businessName;
  final DateTime date;
  final String timeSlot;
  final double price;
  final BookingStatus status;
  final String imageUrl;

  Booking({
    required this.id,
    required this.serviceName,
    required this.businessName,
    required this.date,
    required this.timeSlot,
    required this.price,
    required this.status,
    required this.imageUrl,
  });
}

enum BookingStatus { confirmed, pending, cancelled, completed }

class Service {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });
}

class Business {
  final String id;
  final String name;
  final String category;
  final String address;
  final double distance;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  Business({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
  });
}
