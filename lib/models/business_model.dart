class BusinessModel {
  String? id;
  String? name;
  String? description;
  String? address;
  String? phoneNumber;
  String? email;
  String? website;
  String? logoUrl;
  String? coverImageUrl;
  List<String>? categories;
  List<String>? tags;
  double? rating;
  int? reviewCount;

  BusinessModel({
    this.id,
    this.name,
    this.description,
    this.address,
    this.phoneNumber,
    this.email,
    this.website,
    this.logoUrl,
    this.coverImageUrl,
    this.categories,
    this.tags,
    this.rating,
    this.reviewCount,
  });
  BusinessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    website = json['website'];
    logoUrl = json['logo_url'];
    coverImageUrl = json['cover_image_url'];
    categories = List<String>.from(json['categories'] ?? []);
    tags = List<String>.from(json['tags'] ?? []);
    rating = (json['rating'] as num?)?.toDouble();
    reviewCount = json['review_count'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'website': website,
      'logo_url': logoUrl,
      'cover_image_url': coverImageUrl,
      'categories': categories,
      'tags': tags,
      'rating': rating,
      'review_count': reviewCount,
    };
  }
  @override
  String toString() {
    return 'BusinessModel{id: $id, name: $name, description: $description, address: $address, phoneNumber: $phoneNumber, email: $email, website: $website, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, categories: $categories, tags: $tags, rating: $rating, reviewCount: $reviewCount}';
  }
}
