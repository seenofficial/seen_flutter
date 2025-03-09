import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../features/home_module/home_imports.dart';
import '../../../service_locator.dart';
import '../../map_services_DI.dart';
import '../controller /map_services_cubit.dart';
import 'base_map_screen.dart';

class ShowLocationScreen extends StatelessWidget {
  final LatLng location;
  final double height;
  const ShowLocationScreen({
    super.key,
    required this.location,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMap(
      height: height,
      points: [
        LatLng( location.latitude, location.longitude),
      ],

    );
  }
}