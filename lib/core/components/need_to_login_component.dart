
import 'package:enmaa/core/components/custom_snack_bar.dart';

void needToLoginSnackBar() {

   CustomSnackBar.show(message: 'You need to login to access this feature', type: SnackBarType.error);
}