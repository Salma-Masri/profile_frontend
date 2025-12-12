import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../constants/colors.dart';
import '../../services/theme_provider.dart';
import '../../custom_widgets/property_widgets/property_status_badge.dart';
import '../../custom_widgets/property_widgets/property_rating_badge.dart';
import '../../custom_widgets/property_widgets/property_booking_badge.dart';

class MostPopularPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MostPopularPage({
    super.key,
    required this.themeProvider,
  });

  @override
  State<MostPopularPage> createState() => _MostPopularPageState();
}

class _MostPopularPageState extends State<MostPopularPage> {
  // Extended popular properties data for the full page
  final List<Map<String, dynamic>> allPopularProperties = [
    {
      'name': 'Luxury Villa',
      'location': 'Damascus',
      'price': 250,
      'status': 'Active',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=300',
      'bookings': 45,
      'isFavorite': false,
    },
    {
      'name': 'Modern Apartment',
      'location': 'Aleppo',
      'price': 180,
      'status': 'Active',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=300',
      'bookings': 38,
      'isFavorite': false,
    },
    {
      'name': 'Cozy Studio',
      'location': 'Lattakia',
      'price': 120,
      'status': 'Active',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300',
      'bookings': 32,
      'isFavorite': false,
    },
    {
      'name': 'Beach House',
      'location': 'Tartus',
      'price': 300,
      'status': 'Active',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300',
      'bookings': 28,
      'isFavorite': false,
    },
    {
      'name': 'City Center Loft',
      'location': 'Damascus',
      'price': 200,
      'status': 'Active',
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=300',
      'bookings': 25,
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Theme.of(context).scaffoldBackgroundColor : kOffWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? kApple : kZeiti,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Most Popular Properties',
          style: TextStyle(
            color: isDark ? Colors.white : kZeiti,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Column(
        children: [
          // Stats header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${allPopularProperties.length} Properties',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: isDark ? kApple : kZeiti,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sorted by popularity',
                      style: TextStyle(
                        color: isDark ? kApple : kZeiti,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Properties list
          Expanded(
            child: allPopularProperties.isEmpty
                ? _buildEmptyState(context, isDark)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: allPopularProperties.length,
                    itemBuilder: (context, index) {
                      return _buildPropertyCard(context, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trending_up_outlined,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No popular properties yet',
              style: TextStyle(
                color: isDark ? Colors.white : kZeiti,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Properties will appear here as they gain popularity.',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back to Dashboard'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? kApple : kZeiti,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, int index, bool isDark) {
    final property = allPopularProperties[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image with favorite heart and ranking badge
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 9, top: 9, bottom: 9),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    property['image'],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 120,
                        height: 120,
                        color: isDark ? Colors.grey[800] : Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            color: isDark ? kApple : kZeiti,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              size: 24,
                              color: isDark ? Colors.grey[600] : Colors.grey[500],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'No image',
                              style: TextStyle(
                                color: isDark ? Colors.grey[600] : Colors.grey[500],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Ranking badge
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: kOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
          // Property Details
          Expanded(
            child: Container(
              height: 120, // Fixed height for consistent layout
              padding: const EdgeInsets.only(left: 3, top: 12, right: 12,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property['name'],
                style: TextStyle(
                  color: isDark ? Colors.white : kZeiti,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2, // Allow name to wrap to 2 lines
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: isDark ? Colors.grey[400] : kAfani,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      property['location'],
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : kAfani,
                        fontSize: 12,
                      ),
                      maxLines: 2, // Allow location to wrap to 2 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const Spacer(),   // ✅ pushes price + bookings all the way to the bottom

              Padding(
                padding: const EdgeInsets.only(bottom: 1, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$${property['price']}',
                          style: TextStyle(
                            color: isDark ? kApple : kZeiti,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/night',
                          style: TextStyle(
                            color: isDark ? kApple : kAfani,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    Row(
                      children: [
                        PropertyBookingBadge(
                          bookings: property['bookings'],
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
              ,
            ),
          ),
          // Status and Rating
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PropertyStatusBadge(
                  status: property['status'],
                  isDark: isDark,
                ),
                const SizedBox(height: 8),
                PropertyRatingBadge(
                  rating: property['rating'].toDouble(),
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}