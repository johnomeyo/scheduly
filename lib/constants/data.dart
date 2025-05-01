import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/models/service_model.dart';

final List<ServiceModel> services = [
  ServiceModel(
    id: '1',
    name: 'Manicure & Pedicure',
    description: 'A relaxing manicure and pedicure session.',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVF0JLqJFCca1r-t4qPeGWRhlLa366R9VB1g&s',
    price: 25.0,
    durationMinutes: 30,
    features: ['Wash', 'Cut', 'Style'],
    rating: 4.5,
    reviewCount: 120,
    availableProfessionals: ['Alice', 'Bob'],
  ),
  ServiceModel(
    id: '2',
    name: 'Gym Training',
    description: 'Personalized gym training session.',
    imageUrl:
        'https://marketplace.canva.com/EAFxdcos7WU/1/0/1600w/canva-dark-blue-and-brown-illustrative-fitness-gym-logo-oqe3ybeEcQQ.jpg',
    price: 15.0,
    durationMinutes: 45,
    features: ['Nail Polish', 'Cuticle Care'],
    rating: 4.7,
    reviewCount: 80,
    availableProfessionals: ['Alice', 'Charlie'],
  ),
  ServiceModel(
    id: '3',
    name: 'Haircut & Styling',
    description: 'Get a fresh haircut and professional styling.',
    imageUrl:
        'https://marketplace.canva.com/EAF6DOq8wwA/2/0/1600w/canva-black-and-white-modern-illustrative-barbershop-logo-b6jlttO-nDo.jpg',
    price: 20.0,
    durationMinutes: 40,
    features: ['Cut', 'Blow-dry', 'Style'],
    rating: 4.8,
    reviewCount: 95,
    availableProfessionals: ['Diana', 'Ethan'],
  ),
  ServiceModel(
    id: '4',
    name: 'Full Body Massage',
    description: 'Relax with a full-body Swedish massage.',
    imageUrl:
        'https://t4.ftcdn.net/jpg/00/99/47/49/360_F_99474971_kvwn04WzYNdXntumZ4ajbDYyfOpKxUoX.jpg',
    price: 35.0,
    durationMinutes: 60,
    features: ['Swedish', 'Deep Tissue', 'Aromatherapy'],
    rating: 4.9,
    reviewCount: 150,
    availableProfessionals: ['Fiona', 'George'],
  ),
];
// Mock data for popular businesses
final List<Business> popularBusinesses = [
  Business(
    id: '1',
    name: 'Wellness Spa Center',
    category: 'Spa & Massage',
    address: '123 Relaxation Ave',
    distance: 1.2,
    rating: 4.9,
    reviewCount: 324,
    imageUrl: 'https://example.com/wellness-spa.jpg',
  ),
  Business(
    id: '2',
    name: 'Modern Hair Studio',
    category: 'Hair & Beauty',
    address: '456 Style St',
    distance: 0.8,
    rating: 4.7,
    reviewCount: 215,
    imageUrl:
        'https://i.pinimg.com/736x/ec/e2/8a/ece28abe4a13dcefbf7f856e45b0a810.jpg',
  ),
  Business(
    id: '3',
    name: 'Elite Fitness Center',
    category: 'Fitness & Training',
    address: '789 Muscle Road',
    distance: 2.5,
    rating: 4.8,
    reviewCount: 178,
    imageUrl:
        'https://marketplace.canva.com/EAFxdcos7WU/1/0/1600w/canva-dark-blue-and-brown-illustrative-fitness-gym-logo-oqe3ybeEcQQ.jpg',
  ),
];

// Mock data for recent searches
final List<String> recentSearches = [
  'Massage therapy',
  'Hair salon near me',
  'Personal trainer',
  'Dental check-up',
];
// Mock data for upcoming bookings
final List<Booking> upcomingBookings = [
  Booking(
    id: '1',
    serviceName: 'Hair Cut & Style',
    businessName: 'Modern Salon',
    date: DateTime.now().add(const Duration(days: 2)),
    timeSlot: '10:00 AM - 11:00 AM',
    price: 45.00,
    status: BookingStatus.confirmed,
    imageUrl: 'https://example.com/salon.jpg',
  ),
  Booking(
    id: '2',
    serviceName: 'Deep Tissue Massage',
    businessName: 'Wellness Spa',
    date: DateTime.now().add(const Duration(days: 5)),
    timeSlot: '2:30 PM - 3:30 PM',
    price: 75.00,
    status: BookingStatus.confirmed,
    imageUrl: 'https://example.com/spa.jpg',
  ),
];
final List<Booking> pastBookings = [
  Booking(
    id: '1',
    serviceName: 'Hair Cut & Style',
    businessName: 'Modern Salon',
    date: DateTime.now().subtract(const Duration(days: 10)),
    timeSlot: '10:00 AM - 11:00 AM',
    price: 200,
    status: BookingStatus.completed,
    imageUrl: '',
  ),
];
