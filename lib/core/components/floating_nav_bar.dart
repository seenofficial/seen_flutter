import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';

class FloatingBottomNavBar extends StatefulWidget {
  final List<FloatingNavBarItem> items;
  final int currentIndex;
  final Function(int) onItemSelected;

  const FloatingBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scale(24),
          ),
          height: context.scale(90),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: .5,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              widget.items.length,
                  (index) => _buildNavItem(index),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildNavItem(int index) {
    final item = widget.items[index];
    final isSelected = index == widget.currentIndex;

    return InkWell(
      onTap: () => widget.onItemSelected(index),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                color: isSelected ? ColorManager.primaryColor : Colors.grey,
              ),
              SizedBox(height: 3.h),
              Text(
                item.text,
                style: TextStyle(
                  color: isSelected ? ColorManager.primaryColor : Colors.grey,
                  fontSize: 12.h,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class FloatingNavBarItem {
  final IconData icon;
  final String text;

  FloatingNavBarItem({
    required this.icon,
    required this.text,
  });
}