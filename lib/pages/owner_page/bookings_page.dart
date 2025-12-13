import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../constants/colors.dart';
import '../../services/theme_provider.dart';
import '../../custom_widgets/common/universal_filter_bar.dart';

class BookingsPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const BookingsPage({
    super.key,
    required this.themeProvider,
  });

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  String selectedFilter = 'All';

  // Sample bookings data
  final List<Map<String, dynamic>> bookings = [
    {
      'id': 'BK001',
      'propertyName': 'Villa',
      'propertyImage': 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=300',
      'location': 'Damascus,',
      'guestName': 'Ahmed Hassan',
      'guestAvatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      'checkIn': '2025-01-15',
      'checkOut': '2025-01-20',
      'nights': 5,
      'totalAmount': 1250,
      'status': 'Upcoming',
      'bookingDate': '2024-12-10',
    },
    {
      'id': 'BK002',
      'propertyName': 'Modern Apartment',
      'propertyImage': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=300',
      'location': 'Aleppo',
      'guestName': 'Sara Ali',
      'guestAvatar': 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
      'checkIn': '2024-12-12',
      'checkOut': '2024-12-15',
      'nights': 3,
      'totalAmount': 540,
      'status': 'Current',
      'bookingDate': '2024-12-05',
    },
    {
      'id': 'BK003',
      'propertyName': 'Cozy Studio',
      'propertyImage': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=300',
      'location': 'Brooklyn, NY',
      'guestName': 'Omar Khalil',
      'guestAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'checkIn': '2024-11-20',
      'checkOut': '2024-11-25',
      'nights': 5,
      'totalAmount': 600,
      'status': 'Cancelled',
      'bookingDate': '2024-11-15',
    },
    {
      'id': 'BK004',
      'propertyName': 'Beach House',
      'propertyImage': 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=300',
      'location': 'Malibu, CA',
      'guestName': 'Layla Mahmoud',
      'guestAvatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      'checkIn': '2025-02-01',
      'checkOut': '2025-02-07',
      'nights': 6,
      'totalAmount': 1800,
      'status': 'Upcoming',
      'bookingDate': '2024-12-08',
    },
    {
      'id': 'BK005',
      'propertyName': 'City Center Loft',
      'propertyImage': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=300',
      'location': 'Chicago, IL',
      'guestName': 'Youssef Nader',
      'guestAvatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      'checkIn': '2024-12-10',
      'checkOut': '2024-12-14',
      'nights': 4,
      'totalAmount': 800,
      'status': 'Current',
      'bookingDate': '2024-12-01',
    },
    {
      'id': 'BK006',
      'propertyName': 'Garden Villa',
      'propertyImage': 'https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?w=300',
      'location': 'Austin, TX',
      'guestName': 'Fatima Al-Zahra',
      'guestAvatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
      'checkIn': '2025-01-25',
      'checkOut': '2025-01-30',
      'nights': 5,
      'totalAmount': 550,
      'status': 'Pending',
      'bookingDate': '2024-12-11',
    },
    {
      'id': 'BK007',
      'propertyName': 'Ocean View Apartment',
      'propertyImage': 'https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=300',
      'location': 'San Diego, CA',
      'guestName': 'Khalid Rashid',
      'guestAvatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      'checkIn': '2025-02-10',
      'checkOut': '2025-02-15',
      'nights': 5,
      'totalAmount': 475,
      'status': 'Pending',
      'bookingDate': '2024-12-09',
    },
  ];

  List<Map<String, dynamic>> get filteredBookings {
    if (selectedFilter == 'All') return bookings;
    return bookings.where((booking) => 
        booking['status'].toString().toLowerCase() == selectedFilter.toLowerCase()).toList();
  }

  Map<String, int> get filterCounts {
    return {
      'All': bookings.length,
      'Upcoming': bookings.where((b) => b['status'] == 'Upcoming').length,
      'Current': bookings.where((b) => b['status'] == 'Current').length,
      'Pending': bookings.where((b) => b['status'] == 'Pending').length,
      'Cancelled': bookings.where((b) => b['status'] == 'Cancelled').length,
    };
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return kKiwi;
      case 'current':
        return const Color(0xff4fbe6f);
      case 'pending':
        return kOrange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey[600]!;
    }
  }

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
          'Bookings',
          style: TextStyle(
            color: isDark ? Colors.white : kZeiti,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              LucideIcons.calendar,
              color: isDark ? Colors.white : kZeiti,
              size: 20,
            ),
            onPressed: () {
              // Show calendar view
            },
          ),
        ],
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
                  '${filteredBookings.length} Bookings',
                  style: TextStyle(
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                // Row(
                //   children: [
                //     // Icon(
                //     //   Icons.attach_money,
                //     //   color: isDark ? kApple : kZeiti,
                //     //   size: 16,
                //     // ),
                //     const SizedBox(width: 4),
                //     // Text(
                //     //   'Total Revenue: \${_calculateTotalRevenue()}',
                //     //   style: TextStyle(
                //     //     color: isDark ? kApple : kZeiti,
                //     //     fontSize: 14,
                //     //     fontWeight: FontWeight.w500,
                //     //   ),
                //     // ),
                //   ],
                // ),
              ],
            ),
          ),
          // Filter bar
          UniversalFilterBar(
            filters: const ['All', 'Upcoming', 'Current', 'Pending', 'Cancelled'],
            selectedFilter: selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
            isDark: isDark,
            filterCounts: filterCounts,
          ),
          const SizedBox(height: 16),
          // Bookings list
          Expanded(
            child: filteredBookings.isEmpty
                ? buildEmptyState(context, isDark)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      return buildBookingCard(context, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }
  // String _calculateTotalRevenue() {
  //   final completedBookings = filteredBookings.where((booking) =>
  //       booking['status'] == 'Current' || booking['status'] == 'Completed').toList();
  //   final total = completedBookings.fold<double>(0, (sum, booking) =>
  //       sum + booking['totalAmount'].toDouble());
  //   return total.toStringAsFixed(0);
  // }

  Widget buildEmptyState(BuildContext context, bool isDark) {
    String message;
    IconData icon;
    
    switch (selectedFilter) {
      case 'Upcoming':
        message = 'No upcoming bookings';
        icon = Icons.schedule;
        break;
      case 'Current':
        message = 'No current bookings';
        icon = Icons.home;
        break;
      case 'Pending':
        message = 'No pending bookings';
        icon = Icons.hourglass_empty;
        break;
      case 'Cancelled':
        message = 'No cancelled bookings';
        icon = Icons.cancel_outlined;
        break;
      default:
        message = 'No bookings yet';
        icon = Icons.calendar_today;
    }
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: isDark ? Colors.white : kZeiti,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              selectedFilter == 'All' 
                  ? 'Bookings will appear here when guests make reservations.'
                  : 'Try selecting a different filter to see other bookings.',
              style: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  Widget buildBookingCard(BuildContext context, int index, bool isDark) {
    final booking = filteredBookings[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with booking type and price
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStatusBadge(booking['status'], isDark),
                Text(
                  '\$${booking['totalAmount']}',
                  style: TextStyle(
                    color: isDark ? kApple : kZeiti,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Property Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                booking['propertyImage'],
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 120,
                    color: isDark ? Colors.grey[800] : Colors.grey[300],
                    child: Icon(
                      Icons.home,
                      color: isDark ? Colors.grey[600] : Colors.grey[500],
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Property details and location
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking['propertyName'],
                  style: TextStyle(
                    color: isDark ? Colors.white : kZeiti,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: isDark ? Colors.grey[400] : kAfani,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking['location'],
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : kAfani,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Date container with status color
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: getStatusColor(booking['status']).withValues(alpha: isDark ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getStatusColor(booking['status']).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        color: getStatusColor(booking['status']),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${booking['checkIn']} - ${booking['checkOut']} (${booking['nights']} nights)',
                          style: TextStyle(
                            color: getStatusColor(booking['status']),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                
                // View button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _viewBookingDetails(booking['id']);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? kApple : kZeiti,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _viewBookingDetails(String bookingId) {
    // Navigate to booking details page or show details dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Details'),
        content: Text('Viewing details for booking: $bookingId'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget buildStatusBadge(String status, bool isDark) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    switch (status.toLowerCase()) {
      case 'upcoming':
        backgroundColor = isDark 
            ? kKiwi.withValues(alpha: 0.2)
            : kKiwi.withValues(alpha: 0.3);
        textColor = isDark ? kKiwi : kZeiti;
        borderColor = kKiwi;
        break;
      case 'current':
        backgroundColor = isDark 
            ? const Color(0xff4fbe6f).withValues(alpha: 0.2)
            : const Color(0xffe7fced);
        textColor = const Color(0xff4fbe6f);
        borderColor = const Color(0xff4fbe6f);
        break;
      case 'pending':
        backgroundColor = isDark 
            ? kOrange.withValues(alpha: 0.2)
            : kOrange.withValues(alpha: 0.1);
        textColor = kOrange;
        borderColor = kOrange;
        break;
      case 'cancelled':
        backgroundColor = isDark 
            ? Colors.red.withValues(alpha: 0.2)
            : Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        borderColor = Colors.red;
        break;
      default:
        backgroundColor = isDark 
            ? Colors.grey[800]!.withValues(alpha: 0.5)
            : Colors.grey.withValues(alpha: 0.3);
        textColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
        borderColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}