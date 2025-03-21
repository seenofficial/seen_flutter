import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/services/shared_preferences_service.dart';
import 'package:enmaa/main.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../home_module/home_imports.dart';

class NameAndPhoneWidget extends StatefulWidget {
  const NameAndPhoneWidget({super.key});

  @override
  State<NameAndPhoneWidget> createState() => _NameAndPhoneWidgetState();
}

class _NameAndPhoneWidgetState extends State<NameAndPhoneWidget> {
  String name='' , phoneNumber= '';

  @override
  void initState() {
    name = SharedPreferencesService().userName.isNotEmpty ? SharedPreferencesService().userName : 'مرحباً بك،';
    phoneNumber = SharedPreferencesService().userPhone.isNotEmpty ? SharedPreferencesService().userPhone : 'أنشئ حساباً لتحصل علي المميزات';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(82),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding:  const EdgeInsets.all(16),
      child: InkWell(
        onTap: (){
          if(isAuth){
            Navigator.of(context).pushNamed(RoutersNames.editUserDataScreen);
          }
          else{
            Navigator.of(context).pushNamed(RoutersNames.authenticationFlow);
          }

        },
        child: Row(
          children: [
            Container(
              width: context.scale(50),
              height: context.scale(50),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                shape:  BoxShape.circle,
              ),
              child: Center(child: Text(name[0] , style: getBoldStyle(color: ColorManager.whiteColor , fontSize: FontSize.s18),)),
            ),
            SizedBox(
              width: context.scale(8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(name , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s16),),
                Text(phoneNumber , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s14),)
              ],
            ),

            Spacer(),

            Icon(Icons.arrow_forward_ios)

          ],
        ),
      ),
    );

  }
}
