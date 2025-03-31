import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppHeader extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final String selectedPlatform;
  final void Function(String?) onPlatformChanged; // ✅ Fixed function type
  final List<String> platforms;

  const AppHeader({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.selectedPlatform,
    required this.onPlatformChanged,
    required this.platforms,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar with Dropdown
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward_rounded, color: theme.colorScheme.primary),
                      onPressed: () => onSearch(controller.text),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                  ),
                  onSubmitted: onSearch,
                ),
              ),
              const SizedBox(width: 12),
              // Dropdown for selecting platform
              DropdownButton<String>(
                value: selectedPlatform,
                icon: const Icon(Icons.filter_list),
                onChanged: onPlatformChanged,
                items: platforms
                    .map((platform) => DropdownMenuItem<String>(
                          value: platform,
                          child: Text(platform),
                        ))
                    .toList(),
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),
        ],
      ),
    );
  }
}
