import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../home_module/home_imports.dart';

class NameAndPhoneWidget extends StatelessWidget {
  const NameAndPhoneWidget({super.key});

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
      child: Row(
        children: [
          Container(
            width: context.scale(50),
            height: context.scale(50),
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
              shape:  BoxShape.circle,
            ),
            child: Center(child: Text('م' , style: getBoldStyle(color: ColorManager.whiteColor , fontSize: FontSize.s18),)),
          ),
          SizedBox(
            width: context.scale(8),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('مصعب الشنقيطي' , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s16),),
              Text('+201005734569' , style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s14),)
            ],
          ),

          Spacer(),

          InkWell(
              onTap: (){
              },
              child: Icon(Icons.arrow_forward_ios)
          )

        ],
      ),
    );

  }
}
