import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/main.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/need_to_login_component.dart';
import '../../../home_module/home_imports.dart';

class UserScreensWidget extends StatelessWidget {
  const UserScreensWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(112),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding:  const EdgeInsets.all(16),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            
                InkWell(
                  onTap: (){
                    if(isAuth) {
                      Navigator.pushNamed(context, RoutersNames.userAppointmentsScreen);
                    }
                    else {
                      needToLoginSnackBar();

                    }
                  },
                  child: Row(
                    children: [
                      SvgImageComponent(
                        width: 20,
                        height: 20,
                        iconPath: AppAssets.myAppointmentIcon , color: ColorManager.grey,) ,
                      SizedBox(width: context.scale(8),),
                      Text('مواعيدي' , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s16),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgImageComponent(
                      width: 20,
                      height: 20,
                      iconPath: AppAssets.electronicContractIcon , color: ColorManager.grey,) ,
                    SizedBox(width: context.scale(8),),
                    Text('عقودي الإلكترونية' , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s16),),
                    Spacer(),
                    InkWell(
                        onTap: (){
                          if(isAuth) {

                           }
                          else {
                            needToLoginSnackBar();
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios)
                    )
                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    );

  }
}
