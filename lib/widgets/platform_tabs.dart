import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlatformTabs extends StatelessWidget {
  final TabController tabController;
  final List<String> platforms;

  const PlatformTabs({
    super.key,
    required this.tabController,
    required this.platforms,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildSearchDropdown(theme),
        _buildTabBar(theme),
      ],
    ).animate().fadeIn(duration: 700.ms, delay: 300.ms);
  }

  /// Dropdown to select a specific platform for search filtering
  Widget _buildSearchDropdown(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        items: platforms
            .map((platform) => DropdownMenuItem(
                  value: platform,
                  child: Text(platform),
                ))
            .toList(),
        onChanged: (selectedPlatform) {
          final index = platforms.indexOf(selectedPlatform!);
          tabController.animateTo(index);
        },
        icon: Icon(Icons.arrow_drop_down_rounded, color: theme.colorScheme.primary),
        hint: const Text('Select a platform'),
      ),
    );
  }

  /// Custom stylized TabBar with smooth animations
  Widget _buildTabBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        controller: tabController,
        tabs: platforms.map((platform) => Tab(text: platform)).toList(),
        labelColor: theme.colorScheme.onPrimary,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: theme.colorScheme.primary,
        ),
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        padding: const EdgeInsets.all(4),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
