import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CustomCachedImageContainer extends StatelessWidget {
  final String? imageUri;
  final double? height;
  final double? width;
  final bool isLocal;
  final double borderRadius;
  const CustomCachedImageContainer({
    Key? key,
    required this.imageUri,
    this.isLocal = false,
    this.width,
    this.height = 200,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUri != null) {
      if (isLocal) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imageUri!),
            ),
          ),
        );
      } else {
        return Container(
          height: height,
          clipBehavior: Clip.hardEdge,
          constraints: const BoxConstraints(
            minHeight: 170,
            minWidth: 200,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: AspectRatio(
            aspectRatio: 2,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (c, i) => Center(
                child: SkeletonItem(
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.black,
                  ),
                ),
              ),
              imageUrl: imageUri!,
              errorWidget: (c, i, d) => const Icon(Icons.error),
            ),
          ),
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
