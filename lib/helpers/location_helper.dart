const MAP_QUEST_KEY = 'Qx1hnVHVJbB8in3dEVpIG5mIA0CEwt76';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://open.mapquestapi.com/staticmap/v4/getmap?key=$MAP_QUEST_KEY&size=600,400&zoom=13&center=$latitude,$longitude';
  }
}
