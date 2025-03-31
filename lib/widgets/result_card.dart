import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class ResultCard extends StatelessWidget {
  final dynamic item;
  final String source;
  final int index;
  final Function() onTap;

  const ResultCard({
    super.key,
    required this.item,
    required this.source,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final platformColor = _getPlatformColor(source, theme.colorScheme);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      elevation: 2,
      surfaceTintColor: theme.colorScheme.surfaceTint.withOpacity(0.05),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlatformIcon(platformColor),
              const SizedBox(width: 16),
              Expanded(child: _buildContent(theme)),
            ],
          ),
        ),
      ),
    ).animate(delay: (50 * index).ms).fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }

  /// Builds the icon box indicating the source platform
  Widget _buildPlatformIcon(Color platformColor) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: platformColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getPlatformIcon(source),
        color: platformColor,
        size: 28,
      ),
    );
  }

  /// Builds the main content of the result card
  Widget _buildContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 4),
        _buildMetaData(theme),
      ],
    );
  }

  /// Builds the title text of the result
  Widget _buildTitle() {
    return Text(
      item['title'],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Builds metadata based on the source platform (Google, Reddit, YouTube, Instagram)
  Widget _buildMetaData(ThemeData theme) {
    if (source == 'Google') {
      return Text(
        item['snippet'],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    } else if (source == 'Reddit') {
      return _buildIconTextRow(Icons.forum, 'r/${item['subreddit']}', theme);
    } else if (source == 'YouTube') {
      return _buildIconTextRow(Icons.play_arrow_rounded, 'Video', theme);
    } else if (source == 'Instagram') {
      return _buildIconTextRow(Icons.camera_alt_rounded, 'Instagram Post', theme);
    }
    return const SizedBox.shrink();
  }

  /// Helper method to create a row with an icon and text
  Widget _buildIconTextRow(IconData icon, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Determines the correct icon for each platform
  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'YouTube': return Icons.play_circle_outline_rounded;
      case 'Google': return Icons.public_rounded;
      case 'Reddit': return Icons.forum_rounded;
      case 'Instagram': return Icons.camera_alt_rounded; // ✅ Added Instagram icon
      default: return Icons.search_rounded;
    }
  }

  /// Determines the correct color for each platform
  Color _getPlatformColor(String platform, ColorScheme colorScheme) {
    switch (platform) {
      case 'YouTube': return AppColors.youtubeRed;
      case 'Google': return AppColors.googleBlue;
      case 'Reddit': return AppColors.redditOrange;
      case 'Instagram': return AppColors.instagramPink; // ✅ Added Instagram color
      default: return colorScheme.primary;
    }
  }
}
