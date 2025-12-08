// App configuration
// Use this to switch between mock data and real API
class AppConfig {
  // ============================================
  // TOGGLE THIS TO SWITCH BETWEEN MOCK AND REAL API
  // ============================================

  // Set to true to use mock data (for testing without backend)
  // Set to false to use real API (when backend is ready)
  static const bool useMockData = true;

  // ============================================
  // BACKEND CONFIGURATION
  // ============================================

  // TODO: Update this with your actual backend URL
  // Examples:
  // - Local development: 'http://localhost:3000/api'
  // - Local network: 'http://192.168.1.100:3000/api'
  // - Production: 'https://api.yourapp.com/api'
  static const String apiBaseUrl = 'http://localhost:3000/api';

  // Current user ID (TODO: Get this from authentication)
  // In a real app, this should come from login response
  static const String currentUserId = '1';
}
