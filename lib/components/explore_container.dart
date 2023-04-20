import 'package:flutter/material.dart';
import 'package:randevu_al/core/theme/colors.style.dart';

class ExploreListContainer extends StatelessWidget {
  final String title;
  final bool isShowAllTapButton;
  final VoidCallback? showAllTap;
  final Widget child;
  const ExploreListContainer({
    Key? key,
    required this.title,
    this.isShowAllTapButton = true,
    this.showAllTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: IColors.primary.withOpacity(0.3),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade400,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      isShowAllTapButton
                          ? TextButton(
                              onPressed: showAllTap,
                              child: Row(
                                children: const [
                                  Text("Hepsini gör "),
                                  Icon(Icons.arrow_circle_right)
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 40,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: child,
          ),
        ],
      ),
    );
  }
}

class ExploreContainerListItem extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  const ExploreContainerListItem({
    Key? key,
    this.child,
    this.width = 100,
    this.height = 100,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: width,
        height: height,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade600,
              width: 1,
            )),
        child: child,
      ),
    );
  }
}
