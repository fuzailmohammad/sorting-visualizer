import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sorting_visualizer/app/data/models/dto/response.dart';
import 'package:sorting_visualizer/app/data/values/strings.dart';
import 'package:sorting_visualizer/app/theme/app_colors.dart';
import 'package:sorting_visualizer/app/theme/styles.dart';
import 'package:sorting_visualizer/widgets/buttons/primary_filled_button.dart';

class ShimmerWidget<D> extends StatelessWidget {
  final Widget? error;
  final Widget shimmer;
  final VoidCallback? onRetry;
  final DataWrapper<D> wrapper;
  final Widget Function(D data) child;

  const ShimmerWidget({
    required this.child,
    required this.shimmer,
    required this.wrapper,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (wrapper.data != null)
      return child(wrapper.data!);
    else if (wrapper.error != null)
      return error ??
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(wrapper.error!, style: Styles.tsPrimaryColorRegular18),
                SizedBox(height: 16),
                PrimaryFilledButton(
                  text: Strings.retry.toUpperCase(),
                  onTap: onRetry ?? () {},
                ),
              ],
            ),
          );
    else
      return Shimmer.fromColors(
        child: shimmer,
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighlightColor,
      );
  }
}
