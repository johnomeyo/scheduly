import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomLocationMap extends StatelessWidget {
  const CustomLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider("https://i.sstatic.net/HILmr.png"),
        ),
      ),
    );
  }
}
