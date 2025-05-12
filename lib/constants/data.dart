import 'package:scheduly/models/booking_model.dart';
import 'package:scheduly/models/business_model.dart';
import 'package:scheduly/models/review_model.dart';
import 'package:scheduly/models/service_model.dart';

final List<ServiceModel> services = [
  ServiceModel(
    id: 's1',
    name: 'Massage Therapy',
    price: '\$75',
    duration: '60 min',
    description: 'Relaxing deep tissue massage to relieve stress and tension.',
  ),
  ServiceModel(
    id: 's2',
    name: 'Facial Treatment',
    price: '\$90',
    duration: '45 min',
    description:
        'Rejuvenating facial that cleanses, exfoliates and hydrates your skin.',
  ),
  ServiceModel(
    id: 's3',
    name: 'Aromatherapy',
    price: '\$60',
    duration: '30 min',
    description:
        'Essential oil therapy to improve physical and emotional well-being.',
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
    status: BookingStatus.pending,
    imageUrl: 'https://example.com/spa.jpg',
  ),
  Booking(
    id: '3',
    serviceName: 'Manicure & Pedicure',
    businessName: 'Nail Bliss Studio',
    date: DateTime.now().add(const Duration(days: 3)),
    timeSlot: '1:00 PM - 2:00 PM',
    price: 35.00,
    status: BookingStatus.cancelled,
    imageUrl: 'https://example.com/nailstudio.jpg',
  ),
  Booking(
    id: '4',
    serviceName: 'Facial Treatment',
    businessName: 'Glow Skincare Lounge',
    date: DateTime.now().add(const Duration(days: 7)),
    timeSlot: '11:30 AM - 12:30 PM',
    price: 60.00,
    status: BookingStatus.confirmed,
    imageUrl: 'https://example.com/skincare.jpg',
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
// Mock user data
final Map<String, dynamic> userData = {
  'name': 'Sarah Johnson',
  'email': 'sarah.johnson@example.com',
  'phone': '+1 (555) 123-4567',
  'profileImage':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzzIJDNaWFPDga2VWx9G4rM2IST-kPixumaw&s',
  'memberSince': 'May 2023',
  'notificationsEnabled': true,
  'address': '123 Main Street, Apt 4B, New York, NY 10001',
  'paymentMethods': [
        {
      'type': 'Credit Card',
      'cardType': 'Visa',
      'lastFour': '4242',
      'isDefault': true,
      'expiryDate': '05/26',
    },
    {
      'type': 'Credit Card',
      'cardType': 'Mastercard',
      'lastFour': '8765',
      'isDefault': false,
      'expiryDate': '10/25',
    },
    

  ],
};
final sampleBusiness = [
  BusinessModel(
    id: 'bus1',
    name: 'Wellness Spa Center',
    tagline: 'Relax. Recharge. Renew.',
    location: '123 Serenity Avenue, Downtown',
    imageUrl:
        "https://media.istockphoto.com/id/867037792/vector/lotus-icon.jpg?s=612x612&w=0&k=20&c=BtCotEldUZfhV99avCEMT8ITXADqgykETGXI90afgPo=",
    rating: 4.8,
    reviewCount: 127,
    about:
        'We offer premium spa services to help you relax and rejuvenate. Our team of professionals is committed to giving you the best service experience.',
    features: ['Open Daily', '9am - 8pm', 'Certified'],
    services: [
      ServiceModel(
        id: 's1',
        name: 'Massage Therapy',
        price: '\$75',
        duration: '60 min',
        description:
            'Relaxing deep tissue massage to relieve stress and tension.',
      ),
      ServiceModel(
        id: 's2',
        name: 'Facial Treatment',
        price: '\$90',
        duration: '45 min',
        description:
            'Rejuvenating facial that cleanses, exfoliates and hydrates your skin.',
      ),
      ServiceModel(
        id: 's3',
        name: 'Aromatherapy',
        price: '\$60',
        duration: '30 min',
        description:
            'Essential oil therapy to improve physical and emotional well-being.',
      ),
    ],
    reviews: [
      ReviewModel(
        id: 'r1',
        reviewerName: 'Sarah Johnson',
        rating: 5.0,
        comment:
            'The massage was incredible! The therapist knew exactly how to address my back pain issues.',
        date: DateTime(2025, 4, 28),
      ),
      ReviewModel(
        id: 'r2',
        reviewerName: 'Michael Chen',
        rating: 4.5,
        comment:
            'Great facial treatment. My skin feels refreshed and rejuvenated.',
        date: DateTime(2025, 4, 22),
      ),
    ],
  ),
  BusinessModel(
    id: 'bus2',
    name: 'Big Gym Center',
    tagline: 'Bulk. Reduce. Build.',
    location: '321 Power Lane, Uptown',
    imageUrl:
        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fitness-logo%2C-gym-logo%2C-fitness-center-logo-%28-design-template-386146ae4164059d8fb5bbf00a6c28bc_screen.jpg?ts=1669139043",
    rating: 4.6,
    reviewCount: 89,
    about:
        'State-of-the-art gym facilities and expert trainers to help you reach your fitness goals.',
    features: ['Open 24/7', 'Personal Trainers', 'Modern Equipment'],
    services: [
      ServiceModel(
        id: 's4',
        name: 'Strength Training',
        price: '\$50',
        duration: '1 hr',
        description: 'Build muscle with our guided weight training program.',
      ),
      ServiceModel(
        id: 's5',
        name: 'HIIT Class',
        price: '\$40',
        duration: '45 min',
        description:
            'High intensity interval training to burn fat and boost metabolism.',
      ),
    ],
    reviews: [
      ReviewModel(
        id: 'r4',
        reviewerName: 'Carlos Gomez',
        rating: 4.7,
        comment:
            'Love the variety of equipment and the helpful trainers. Super clean facility too!',
        date: DateTime(2025, 3, 10),
      ),
    ],
  ),
  BusinessModel(
    id: 'bus3',
    name: 'Glow Beauty Lounge',
    tagline: 'Shine Inside & Out.',
    location: '456 Glamour Blvd, Midtown',
    imageUrl:
        "https://i.pinimg.com/736x/6e/40/d9/6e40d934bdf96936ed96957846872fde.jpg",
    rating: 4.9,
    reviewCount: 203,
    about:
        'A modern beauty lounge offering hair, nail, and skincare services tailored for your glow-up.',
    features: ['Walk-ins Welcome', 'Organic Products', 'Expert Stylists'],
    services: [
      ServiceModel(
        id: 's6',
        name: 'Hair Styling',
        price: '\$65',
        duration: '45 min',
        description:
            'Trendy cuts and styling for all hair types by our expert stylists.',
      ),
      ServiceModel(
        id: 's7',
        name: 'Manicure & Pedicure',
        price: '\$50',
        duration: '1 hr',
        description: 'Deluxe nail care with polish and massage.',
      ),
    ],
    reviews: [
      ReviewModel(
        id: 'r5',
        reviewerName: 'Amina Wafula',
        rating: 5.0,
        comment:
            'Fantastic service! Left feeling like a queen. Loved the vibe and professionalism.',
        date: DateTime(2025, 2, 18),
      ),
    ],
  ),
];
