import 'dart:io';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:flutter/material.dart';

enum OBAvatarSize { extraSmall, small, medium, large, extraLarge }

enum OBAvatarType { user, community }

class OBAvatar extends StatelessWidget {
  final String avatarUrl;
  final File avatarFile;
  final OBAvatarSize size;
  final VoidCallback onPressed;
  final double borderWidth;

  static const double AVATAR_SIZE_EXTRA_SMALL = 20.0;
  static const double AVATAR_SIZE_SMALL = 30.0;
  static const double AVATAR_SIZE_MEDIUM = 40.0;
  static const double AVATAR_SIZE_LARGE = 80.0;
  static const double AVATAR_SIZE_EXTRA_LARGE = 100.0;
  static const String DEFAULT_AVATAR_ASSET = 'assets/images/avatar.jpg';
  static const double avatarBorderRadius = 10.0;

  static double getAvatarSize(OBAvatarSize size) {
    double avatarSize;

    switch (size) {
      case OBAvatarSize.extraSmall:
        avatarSize = AVATAR_SIZE_EXTRA_SMALL;
        break;
      case OBAvatarSize.small:
        avatarSize = AVATAR_SIZE_SMALL;
        break;
      case OBAvatarSize.medium:
        avatarSize = AVATAR_SIZE_MEDIUM;
        break;
      case OBAvatarSize.large:
        avatarSize = AVATAR_SIZE_LARGE;
        break;
      case OBAvatarSize.extraLarge:
        avatarSize = AVATAR_SIZE_EXTRA_LARGE;
        break;
    }

    return avatarSize;
  }

  const OBAvatar(
      {this.avatarUrl,
      this.size = OBAvatarSize.small,
      this.onPressed,
      this.avatarFile,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    OBAvatarSize finalSize = size ?? OBAvatarSize.small;
    double avatarSize = getAvatarSize(finalSize);

    Widget finalAvatarImage;

    if (avatarFile != null) {
      finalAvatarImage = FadeInImage(
        fit: BoxFit.cover,
        height: avatarSize,
        width: avatarSize,
        placeholder: AssetImage(DEFAULT_AVATAR_ASSET),
        image: FileImage(avatarFile),
      );
    } else if (avatarUrl != null) {
      finalAvatarImage = Image(
          height: avatarSize,
          width: avatarSize,
          fit: BoxFit.cover,
          image: AdvancedNetworkImage(avatarUrl, useDiskCache: true));
    } else {
      finalAvatarImage = _getAvatarPlaceholder(avatarSize);
    }

    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(avatarBorderRadius),
      child: finalAvatarImage,
    );

    if (onPressed == null) return avatar;

    return GestureDetector(
      child: avatar,
      onTap: onPressed,
    );
  }

  Widget _getAvatarPlaceholder(double avatarSize) {
    return Image.asset(
      DEFAULT_AVATAR_ASSET,
      height: avatarSize,
      width: avatarSize,
    );
  }
}