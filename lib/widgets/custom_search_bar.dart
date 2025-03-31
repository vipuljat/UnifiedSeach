import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final String selectedPlatform;
  final Function(String?) onPlatformChanged;
  final List<String> platforms;

  const CustomSearchBar({
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search across platforms...',
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
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
                onSubmitted: onSearch,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Platform Dropdown Selection
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
      ),
    ).animate().fadeIn(duration: 700.ms, delay: 200.ms).slideY(begin: 0.2, end: 0);
  }
}
