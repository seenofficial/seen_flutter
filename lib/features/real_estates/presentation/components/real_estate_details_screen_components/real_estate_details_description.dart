import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../configuration/managers/font_manager.dart';
import '../../../../../configuration/managers/style_manager.dart';
import '../../../../../core/components/expandable_description_box.dart';
import '../../../../home_module/home_imports.dart';

class RealEstateDetailsDescription extends StatelessWidget {
  const RealEstateDetailsDescription({super.key, this.description = 'شقة فاخرة للبيع في قلب القاهرة، تجمع بين الأناقة والراحة بتصميم عصري وتشطيبات عالية الجودة. تقع في موقع استراتيجي يتيح لك سهولة الوصول إلى أهم الخدمات والمرافق. لا تفوت الفرصة لامتلاك منزل أحلامك في واحدة من أرقى مناطق القاهرة! تواصل معنا الآن للحجز أو الاستفسار.'});

  final String description ;
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوصف :',
          style: getBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s12),
        ),
        SizedBox(height: context.scale(8)),
        ExpandableDescriptionBox(
            description:description),
      ],
    );
  }
}
