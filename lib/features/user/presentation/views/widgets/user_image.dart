import 'package:attendance_appp/features/user/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UerImage extends StatelessWidget {
  const UerImage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(radius: 50, backgroundImage: imageProvider),
        fit: BoxFit.cover,
        imageUrl: user.imageUrl ?? '',
        errorWidget: (context, url, error) {
          return CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 50),
          );
        },
        placeholder: (context, url) =>
            const CircleAvatar(radius: 50, backgroundColor: Colors.grey),
      ),
    );
  }
}
