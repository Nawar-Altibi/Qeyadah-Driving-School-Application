import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';

/// Full-screen pinch-zoom viewer for a single network image, pushed as a
/// route. Reusable anywhere a document/photo thumbnail needs an in-app
/// preview instead of handing off to an external browser.
class AppFullScreenImageViewer extends StatelessWidget {
  const AppFullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.title,
  });

  final String imageUrl;
  final String? title;

  static Future<void> open(
    BuildContext context, {
    required String imageUrl,
    String? title,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            AppFullScreenImageViewer(imageUrl: imageUrl, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: title == null
            ? null
            : Text(title!, style: const TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.muted,
                    size: 48,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
