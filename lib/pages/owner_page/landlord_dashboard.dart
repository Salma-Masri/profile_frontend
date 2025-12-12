import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../constants/colors.dart';
import '../../models/user.dart';
import '../../services/theme_provider.dart';
import '../../custom_widgets/property_widgets/property_status_badge.dart';
import '../../custom_widgets/property_widgets/property_rating_badge.dart';
import '../../custom_widgets/property_widgets/property_booking_badge.dart';
import '../../custom_widgets/property_widgets/property_filter_bar.dart';
import 'most_popular_page.dart';
import 'bookings_page.dart';

class LandlordDashboard extends StatefulWidget {
  final User user;
  final ThemeProvider themeProvider;

  const LandlordDashboard({
    super.key,
    required this.user,
    required this.themeProvider,
  });

  @override
  State<LandlordDashboard> createState() => _LandlordDashboardState();
}

class _LandlordDashboardState extends State<LandlordDashboard> {
  String selectedFilter = 'All';
  
  // Sample property data
  final List<Map<String, dynamic>> properties = [
    {
      'name': 'villa',
      'location': 'Homs',
      'price': 120,
      'status': 'Active',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=300',
      'isFavorite': false,
    },
    {
      'name': 'House',
      'location': 'Lattakia',
      'price': 200,
      'status': 'Active',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Modern Apartment',
      'location': 'Los Angeles, CA',
      'price': 85,
      'status': 'Pending',
      'rating': 4.5,
      'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Cozy Studio',
      'location': 'San Francisco, CA',
      'price': 75,
      'status': 'Active',
      'rating': 4.3,
      'image': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Luxury Penthouse',
      'location': 'Miami, FL',
      'price': 350,
      'status': 'Blocked',
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Garden Villa',
      'location': 'Austin, TX',
      'price': 110,
      'status': 'Inactive',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Ocean View Apartment',
      'location': 'Santa Monica, CA',
      'price': 95,
      'status': 'Active',
      'rating': 4.6,
      'image': 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=300',
      'isFavorite': false,
    },
    {
      'name': 'Downtown Loft',
      'location': 'New York, NY',
      'price': 150,
      'status': 'Inactive',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1502672023488-70e25813eb80?w=300',
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> get filteredProperties {
    if (selectedFilter == 'All') return properties;
    return properties.where((property) => 
        property['status'].toString().toLowerCase() == selectedFilter.toLowerCase()).toList();
  }

  // Sample popular properties data (top performing)
  final List<Map<String, dynamic>> popularProperties = [
    {
      'name': 'Villa',
      'location': 'Damascus',
      'price': 250,
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=300',
      'bookings': 45,
    },
    {
      'name': 'Modern Apartment',
      'location': 'Aleppo',
      'price': 180,
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=300',
      'bookings': 38,
    },
    {
      'name': 'Cozy Studio',
      'location': 'Lattakia',
      'price': 120,
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300',
      'bookings': 32,
    },
    {
      'name': 'Beach House',
      'location': 'Tartus',
      'price': 300,
      'rating': 5.0,
      'image': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300',
      'bookings': 28,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: buildStatsContainer(context),
          ),
          SliverToBoxAdapter(
            child: buildPopularPropertiesSection(context, isDark),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Properties',
                    style: TextStyle(
                      color: isDark ? Colors.white : kZeiti,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add new property
                    },
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add New', style: TextStyle(fontSize: 13)),
                    iconAlignment: IconAlignment.start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.grey[700] : kZeiti,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PropertyFilterBar(
              selectedFilter: selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
              isDark: isDark,
              properties: properties,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          filteredProperties.isEmpty
              ? SliverToBoxAdapter(
                  child: buildEmptyMyProperties(context, isDark),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildPropertyCard(context, index, isDark),
                      );
                    },
                    childCount: filteredProperties.length,
                  ),
                ),
          SliverToBoxAdapter(
            child: buildMarketInsightContainer(context, isDark),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return SliverAppBar(
      expandedHeight: 140,
      collapsedHeight: 60,
      floating: false,
      pinned: true,
      backgroundColor: isDark ? Colors.grey[850] : kZeiti,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Landlord Dashboard',
        style: TextStyle(
          color: isDark ? Colors.white : Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(LucideIcons.settings, color: isDark ? Colors.white70 : Colors.white70, size: 20),
          onPressed: () {
            // Navigate to settings
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : kZeiti,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 60),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      LucideIcons.home,
                      color:Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back',
                            style: TextStyle(
                              color: isDark ? Colors.grey[400] : Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPropertyCard(BuildContext context, int index, bool isDark) {
    final property = filteredProperties[index];
    
    return Container(
      height: 150, // Fixed height for all property cards
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
          // Property Image with favorite heart
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 9, top: 9, bottom: 9),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    // 'https://via.placeholder.com/150',
                    property['image'],
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.apartment, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
          // Property Details
          Expanded(
            child: Container(
              height: 130, // Fixed height for the details section
              padding: const EdgeInsets.only(left: 3, top: 12, right: 12, bottom: 12),
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
                  const Spacer(), // This pushes the price to the bottom

                  Row(
                      children: [
                        Text(
                          '\$${property['price']}',
                          style: TextStyle(
                            color: isDark ? Colors.white : kZeiti,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        '/night',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : kAfani,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget buildStatsContainer(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        transform: Matrix4.translationValues(0, -30, 0),
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).cardColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: buildStatItem(
                  value: '\$2.4k',
                  label: 'Revenue',
                  isDark: isDark,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 0.5,
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
              Expanded(
                child: buildStatItem(
                  value: '${properties.length}',
                  label: 'Properties',
                  isDark: isDark,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 0.5,
                color: isDark ? Colors.grey[700] : Colors.grey[300],
              ),
              Expanded(
                child: buildStatItem(
                  value: '85%',
                  label: 'Occupancy',
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatItem({
    required String value,
    required String label,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : kZeiti,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPopularPropertiesSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Most Popular',
                style: TextStyle(
                  color: isDark ? Colors.white : kZeiti,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MostPopularPage(
                        themeProvider: widget.themeProvider,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: isDark ? Colors.white : kZeiti,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: isDark ? Colors.white : kZeiti,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: popularProperties.isEmpty ? 2 : 12),
        SizedBox(
          height:popularProperties.isEmpty? 60 : 260,
          child: popularProperties.isEmpty 
              ? buildEmptyPopularProperties(context, isDark)
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularProperties.length + 1, // +1 for the arrow button
                  itemBuilder: (context, index) {
                    if (index == popularProperties.length) {
                      // Show arrow button at the end
                      return buildViewAllArrowCard(context, isDark);
                    }
                    return buildPopularPropertyCard(context, index, isDark);
                  },
                ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPopularPropertyCard(BuildContext context, int index, bool isDark) {
    final property = popularProperties[index];
    
    return Container(
      width: 180,
      // height: 500, // Fixed height for all cards
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Floating Property Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              property['image'],
              width: double.infinity,
              height: 130,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: double.infinity,
                  height: 130,
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
                  width: double.infinity,
                  height: 130,
                  color: isDark ? Colors.grey[800] : Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_outlined,
                        size: 32,
                        color: isDark ? Colors.grey[600] : Colors.grey[500],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Image not available',
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
          //),
          // Property Details with fixed positioning
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  property['name'],
                  style: TextStyle(
                    color: isDark ? Colors.white : kZeiti,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: isDark ? Colors.grey[400] : kAfani,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        property['location'],
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : kAfani,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // const SizedBox(height: 10), // Fixed spacing before price
                Row(
                  children: [
                    Text(
                      '\$${property['price']}',
                      style: TextStyle(
                        color: isDark ? kApple : kZeiti,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                    '/night',
                      style: TextStyle(
                        color: isDark ? kApple : kAfani,
                        fontSize: 12,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PropertyBookingBadge(
                      bookings: property['bookings'],
                      isDark: isDark,
                    ),
                    PropertyRatingBadge(
                      rating: property['rating'].toDouble(),
                      isDark: isDark,
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyPopularProperties(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.trending_up_outlined,
            size: 32,
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'No popular properties yet',
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyMyProperties(BuildContext context, bool isDark) {
    final isFiltered = selectedFilter != 'All';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isFiltered ? Icons.filter_list_off : Icons.home_outlined,
              size: 48,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isFiltered ? 'No $selectedFilter properties' : 'No properties yet',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isFiltered 
                  ? 'Try selecting a different filter'
                  : 'Add your first property to get started',
              style: TextStyle(
                color: isDark ? Colors.grey[500] : Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildViewAllArrowCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MostPopularPage(
              themeProvider: widget.themeProvider,
            ),
          ),
        );
      },
      child: Container(
        width: 60,
        margin: const EdgeInsets.only(right: 12),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? kApple.withValues(alpha: 0.2) : kZeiti,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: isDark ? kApple : Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMarketInsightContainer(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Theme.of(context).cardColor : kAfathGreen,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? kApple.withValues(alpha: 0.3) : kZeiti,
          width: 0.2,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withValues(alpha: 0.1),
        //     blurRadius: 8,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark 
                  ? kApple.withValues(alpha: 0.2)
                  : kZeiti.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.trending_up,
              color: isDark ? Colors.white : kZeiti,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Market Insight',
                  style: TextStyle(
                    color: isDark ? Colors.white : kZeiti,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rental prices in Damascus have increased by 5% this month. Consider reviewing your rates.',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : kAfani,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
