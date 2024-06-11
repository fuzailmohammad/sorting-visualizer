import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sorting_visualizer/app/theme/styles.dart';
import 'package:sorting_visualizer/widgets/buttons/primary_filled_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                boxShadow: kElevationToShadow[4],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                        () => CustomDropdown<String>(
                      items: controller.sortingTechnique,
                      selectedItem: controller.selectedTechnique.value,
                      label: 'Select Sorting Technique',
                      onChanged: (value) {
                        controller.setSelectedTechnique(value!);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Obx(
                        () => CustomDropdown<String>(
                      items: controller.speed,
                      selectedItem: controller.selectedSpeed.value,
                      label: 'Select Speed',
                      onChanged: (value) {
                        controller.setSelectedSpeed(value!);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  PrimaryFilledButton(
                    text: "Randomize Array",
                    onTap: controller.addRandomValues,
                  ),
                  SizedBox(width: 16),
                  PrimaryFilledButton(
                    text: "Sort!",
                    onTap: controller.onSortClick,
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.array.isEmpty) {
                return Center(
                  child: Text('Please add random array'),
                );
              } else {
                return SizedBox(
                  height: 550,
                  width: Get.width,
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.array.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        bool isSorted = controller.sortedIndices.contains(index);
                        bool isChecking = controller.isCheckingIndex.value == index;
                        return Bar(
                          width: controller.array[index],
                          isSorted: isSorted,
                          isChecking: isChecking,
                        );
                      });
                    },
                  ),
                );
              }
            }),

          ],
        ),
      ),
    );
  }
}


class Bar extends StatelessWidget {
  const Bar({
    super.key,
    required this.width,
    required this.isSorted,
    required this.isChecking,
  });

  final double width;
  final bool isSorted;
  final bool isChecking;

  @override
  Widget build(BuildContext context) {
    // Determine the maximum possible width
    const maxWidth = 800.0;

    // Calculate the width percentage relative to the maximum width
    final widthPercentage = width / maxWidth;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Stack(
        children: [
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            height: 20,
            width: widthPercentage * 800,
            decoration: BoxDecoration(
              color:isChecking ? Colors.redAccent : isSorted ? Colors.greenAccent : Colors.blueAccent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                width.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T selectedItem;
  final String label;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({super.key,
    required this.items,
    required this.selectedItem,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      dropdownMenuEntries: items.map((item) {
        return DropdownMenuEntry<T>(
          value: item,
          label: item.toString(),
        );
      }).toList(),
      initialSelection: selectedItem,
      onSelected: onChanged,
      label: Text(label),
      textStyle: Styles.tsPrimaryColorRegular18,
    );
  }
}
