import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../constants/colors.dart';
import '../../models/user.dart';
import '../../services/theme_provider.dart';

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
      'status': 'Active',
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
      'status': 'Active',
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildPropertyCard(context, index, isDark),
                );
              },
              childCount: properties.length,
            ),
          ),
          SliverToBoxAdapter(
            child: _buildMarketInsightContainer(context, isDark),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    final isDark = widget.themeProvider.isDarkMode;
    
    return SliverAppBar(
      expandedHeight: 180,
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
                      padding: const EdgeInsets.only(bottom: 24),
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
    final property = properties[index];
    
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
          // Property Image with favorite heart
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
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
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      properties[index]['isFavorite'] = !properties[index]['isFavorite'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      property['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: property['isFavorite'] ? Colors.red : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Property Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, top: 12),
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
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
                        // fontWeight: FontWeight.bold,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: property['status'] == 'Active' 
                          ? const Color(0xff4fbe6f) 
                          : (isDark ? Colors.grey[600]! : Colors.grey[400]!),
                      width: 0.2,
                    ),
                    color: property['status'] == 'Active' 
                        ? (isDark 
                            ? const Color(0xff4fbe6f).withValues(alpha: 0.2)
                            : const Color(0xffe7fced))
                        : (isDark 
                            ? Colors.grey[800]!.withValues(alpha: 0.5)
                            : Colors.grey.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    property['status'],
                    style: TextStyle(
                      color: property['status'] == 'Active' 
                          ? const Color(0xff4fbe6f) 
                          : (isDark ? Colors.grey[400] : Colors.grey[700]),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? kApple : kZeiti,
                      width: 0.2,
                    ),
                    color: isDark 
                        ? kApple.withValues(alpha: 0.2)
                        : kAfathGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: isDark ? kOrange : kZeiti,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        property['rating'].toString(),
                        style: TextStyle(
                          color: isDark ? kOrange : kZeiti,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
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
          borderRadius: BorderRadius.circular(16),
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
                  value: '12',
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

  Widget _buildMarketInsightContainer(BuildContext context, bool isDark) {
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
              color: isDark ? kApple : kZeiti,
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
