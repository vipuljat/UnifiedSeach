import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptyState extends StatelessWidget {
  final String selectedPlatform;

  const EmptyState({super.key, required this.selectedPlatform});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getPlatformIcon(selectedPlatform),
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'No results for $selectedPlatform',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching again or select a different platform.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  // Assigns different icons for different platforms
  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'YouTube':
        return Icons.play_circle_outline_rounded;
      case 'Google':
        return Icons.public_rounded;
      case 'Reddit':
        return Icons.forum_rounded;
      case 'Instagram':
        return Icons.camera_alt_rounded;
      default:
        return Icons.search_off_rounded;
    }
  }
}
