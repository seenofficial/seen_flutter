import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';

class LoadingOverlayComponent extends StatelessWidget {
  const LoadingOverlayComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(
          color: ColorManager.primaryColor,
        ),
      ),
    );
  }
}
