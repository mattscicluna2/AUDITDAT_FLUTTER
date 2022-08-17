
class AppConstants {
  static const bool debug = true;
  static String stagingEndpoint = 'http://10.0.2.2';
  static String prodEndpoint = 'https://updat.com.mt';

  static String getEndpointUrl() {
    return debug ? stagingEndpoint : prodEndpoint;
  }
}
