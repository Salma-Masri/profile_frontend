class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? country;
  final String? profileImage;
  final String? identificationCard;
  final String? password;
  final String? emailVerifiedAt;
  final String? rememberToken;
  final String? createdAt;
  final String? role;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNumber,
    this.city,
    this.country,
    this.profileImage,
    this.identificationCard,
    this.password,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.role,
  });

  String get name => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'] ?? 'User',
      lastName: json['last_name'] ?? '',
      email: json['email'],
      phoneNumber: json['phone_number'],
      city: json['city'],
      country: json['country'],
      profileImage: json['profile_image'],
      identificationCard: json['identification_card'],
      password: json['password'],
      emailVerifiedAt: json['email_verified_at'],
      rememberToken: json['remember_token'],
      createdAt: json['created_at'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'city': city,
      'country': country,
      'profile_image': profileImage,
      'identification_card': identificationCard,
      'password': password,
      'email_verified_at': emailVerifiedAt,
      'remember_token': rememberToken,
      'created_at': createdAt,
      'role': role,
    };
  }

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? country,
    String? profileImage,
    String? identificationCard,
    String? password,
    String? emailVerifiedAt,
    String? rememberToken,
    String? createdAt,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      country: country ?? this.country,
      profileImage: profileImage ?? this.profileImage,
      identificationCard: identificationCard ?? this.identificationCard,
      password: password ?? this.password,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      rememberToken: rememberToken ?? this.rememberToken,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
    );
  }
}
