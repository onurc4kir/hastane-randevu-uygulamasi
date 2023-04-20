import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletons/skeletons.dart';
import 'package:randevu_al/core/theme/colors.style.dart';

class CustomAvatarContainer extends StatefulWidget {
  final String? profileImageUrl;
  final bool isEditable;
  final Function(File image)? onImagePicked;
  final double radius;
  const CustomAvatarContainer({
    Key? key,
    this.profileImageUrl,
    this.isEditable = true,
    this.onImagePicked,
    this.radius = 120,
  }) : super(key: key);

  @override
  State<CustomAvatarContainer> createState() => _CustomAvatarContainerState();
}

class _CustomAvatarContainerState extends State<CustomAvatarContainer> {
  late final ImagePicker _picker;
  File? pickedImage;
  bool isLoading = false;

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isEditable ? 16.0 : 0),
      child: Center(
        child: isLoading
            ? const CupertinoActivityIndicator()
            : Stack(
                alignment: Alignment.bottomRight,
                clipBehavior: Clip.none,
                children: [
                  _buildImageContainer(),
                  if (widget.isEditable) _buildEditButton(),
                ],
              ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          final result = await _picker.pickImage(source: ImageSource.gallery);
          if (result != null) {
            setState(() {
              pickedImage = File(result.path);
              if (widget.onImagePicked != null) {
                widget.onImagePicked!(pickedImage!);
              }
            });
          }
          setState(() {
            isLoading = false;
          });
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: IColors.primary,
          ),
          child: const Icon(
            Icons.edit,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    if (widget.profileImageUrl == null || pickedImage != null) {
      return Container(
        width: widget.radius,
        height: widget.radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: pickedImage != null
                ? MemoryImage(pickedImage!.readAsBytesSync()) as ImageProvider
                : const NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
          ),
        ),
      );
    }

    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: widget.radius,
      height: widget.radius,
      imageUrl: widget.profileImageUrl!,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        maxRadius: widget.radius,
        backgroundImage: imageProvider,
      ),
      errorWidget: (c, i, s) => const Icon(Icons.error),
      placeholder: (c, s) => SkeletonAvatar(
        style: SkeletonAvatarStyle(
          height: widget.radius,
          width: widget.radius,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
