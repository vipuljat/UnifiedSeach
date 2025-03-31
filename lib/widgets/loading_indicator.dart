import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingIndicator extends StatelessWidget {
  final String selectedPlatform;

  const LoadingIndicator({super.key, required this.selectedPlatform});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary)
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                duration: 700.ms,
                curve: Curves.easeInOut,
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.2, 1.2),
              )
              .then()
              .scale(
                duration: 700.ms,
                curve: Curves.easeInOut,
                begin: const Offset(1.2, 1.2),
                end: const Offset(0.8, 0.8),
              ),
          const SizedBox(height: 16),
          Text(
            _getLoadingMessage(selectedPlatform),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  // Assigns different loading messages based on the selected platform
  String _getLoadingMessage(String platform) {
    switch (platform) {
      case 'YouTube':
        return 'Fetching the latest videos...';
      case 'Google':
        return 'Gathering search results...';
      case 'Reddit':
        return 'Loading trending discussions...';
      case 'Instagram':
        return 'Fetching latest posts...';
      default:
        return 'Searching across platforms...';
    }
  }
}
