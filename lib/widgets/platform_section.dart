import 'package:flutter/material.dart';
import 'result_card.dart';
import '../constants/app_colors.dart';

class PlatformSection extends StatelessWidget {
  final String title;
  final List<dynamic>? items;
  final Function(String, dynamic) onItemTap;

  const PlatformSection({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null || items!.isEmpty) {
      return _buildEmptyState(context);
    }

    final theme = Theme.of(context);
    final platformColor = _getPlatformColor(title, theme.colorScheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPlatformHeader(title, platformColor),
        _buildScrollableContent(),
      ],
    );
  }

  Widget _buildPlatformHeader(String title, Color platformColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Row(
        children: [
          Icon(_getPlatformIcon(title), color: platformColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: platformColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent() {
    return SizedBox(
      height: 400, // Scrollable height limit
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: items!.length,
        itemBuilder: (context, index) {
          return ResultCard(
            item: items![index],
            source: title,
            index: index,
            onTap: () => onItemTap(title, items![index]),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 60, color: theme.colorScheme.primary.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No results found for $title',
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

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
        return Icons.search_rounded;
    }
  }

  Color _getPlatformColor(String platform, ColorScheme colorScheme) {
    switch (platform) {
      case 'YouTube':
        return AppColors.youtubeRed;
      case 'Google':
        return AppColors.googleBlue;
      case 'Reddit':
        return AppColors.redditOrange;
      case 'Instagram':
        return AppColors.instagramPink;
      default:
        return colorScheme.primary;
    }
  }
}
