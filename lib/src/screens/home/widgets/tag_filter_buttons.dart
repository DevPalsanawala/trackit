import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/transcation_cottroller.dart';
import 'package:trackit/src/models/transaction_model.dart';

class TagFilterButtons extends StatelessWidget {
  const TagFilterButtons({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranscationCottroller>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // All button
          Obx(() => FilterButton(
                isSelected: controller.selectedFilterTag.value == null,
                onPressed: () => controller.setFilterTag(null),
                icon: Icons.filter_list,
                label: 'All',
                isDark: isDark,
              )),
          // Tag buttons
          ...Tag.values
              .map((tag) => Obx(() => FilterButton(
                    isSelected: controller.selectedFilterTag.value == tag,
                    onPressed: () => controller.setFilterTag(tag),
                    icon: tagIcons[tag]!,
                    label: tag.name.toUpperCase(),
                    isDark: isDark,
                  )))
              .toList(),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isDark,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 22,
          color: isSelected
              ? (isDark ? dSecondaryColor : dPrimaryColor)
              : (isDark ? dPrimaryColor : dSecondaryColor),
        ),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? (isDark ? dPrimaryColor : dSecondaryColor)
              : (isDark ? dSecondaryColor : dPrimaryColor),
          foregroundColor: isSelected
              ? (isDark ? dSecondaryColor : dPrimaryColor)
              : (isDark ? dPrimaryColor : dSecondaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
