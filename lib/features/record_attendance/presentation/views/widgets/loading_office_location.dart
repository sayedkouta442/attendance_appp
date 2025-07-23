import 'package:flutter/material.dart';

class LoadingOfficeLocation extends StatelessWidget {
  const LoadingOfficeLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          width: double.infinity,
          height: 400,

          child: const Center(
            child: Text(
              'Loading Office location...',
              style: TextStyle(color: Colors.white, fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
