import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';

class LoadingOverlayComponent extends StatelessWidget {
  const LoadingOverlayComponent({super.key , this.opacity});

  final double ? opacity;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(opacity == null ?  0.5 : opacity!),
      child: Center(
        child: CircularProgressIndicator(
          color: ColorManager.primaryColor,
        ),
      ),
    );
  }
}
