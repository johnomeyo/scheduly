import 'package:scheduly/models/service_model.dart';

final List<ServiceModel> services = [
  ServiceModel(
    id: '1',
    name: 'Haircut',
    description: 'A stylish haircut to refresh your look.',
    imageUrl: 'https://example.com/haircut.jpg',
    price: 25.0,
    durationMinutes: 30,
    features: ['Wash', 'Cut', 'Style'],
    rating: 4.5,
    reviewCount: 120,
    availableProfessionals: ['Alice', 'Bob'],
  ),
  ServiceModel(
    id: '2',
    name: 'Manicure',
    description: 'A relaxing manicure to pamper your hands.',
    imageUrl: 'https://example.com/manicure.jpg',
    price: 15.0,
    durationMinutes: 45,
    features: ['Nail Polish', 'Cuticle Care'],
    rating: 4.7,
    reviewCount: 80,
    availableProfessionals: ['Alice', 'Charlie'],
  ),
];
