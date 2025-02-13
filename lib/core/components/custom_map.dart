import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({super.key, required this.points});

  final List<LatLng> points;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: points.isNotEmpty ? points[0] : LatLng(30.0444, 31.2357), // Default to Cairo if empty
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: points.map((point) {
            return Marker(
              width: 40.0,
              height: 40.0,
              point: point,
              child: Icon(
                Icons.location_pin,
                color: ColorManager.yellowColor,
                size: 40,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
