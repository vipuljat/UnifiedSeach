import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // For Clipboard
import '../widgets/custom_search_bar.dart';
import '../widgets/app_header.dart';
import '../widgets/platform_tabs.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/empty_state.dart';
import '../widgets/platform_section.dart';
import '../widgets/result_card.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> _results = {};
  bool _isLoading = false;
  late TabController _tabController;

  final List<String> _platforms = [
    'All',
    'YouTube',
    'Google',
    'Reddit',
    'Instagram',
  ];
  String _selectedPlatform = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _platforms.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedPlatform = _platforms[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a search query')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final results = await ApiService.search(query);
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> _launchUrl(String source, dynamic item) async {
    String url;
    switch (source) {
      case 'YouTube':
        url = 'https://www.youtube.com/watch?v=${item['videoId']}';
        break;
      case 'Google':
        url = item['link'];
        break;
      case 'Reddit':
        url = 'https://www.reddit.com${item['permalink']}';
        break;
      case 'Instagram':
        url = item['postUrl'];
        break;
      default:
        return;
    }

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            action: SnackBarAction(
              label: 'Copy',
              onPressed: () => Clipboard.setData(ClipboardData(text: url)),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppHeader(
            //   controller: _controller,
            //   onSearch: _search, // ✅ Ensure this function is passed
            //   selectedPlatform: _selectedPlatform,
            //   onPlatformChanged: (String? platform) {
            //     if (platform != null) {
            //       setState(() {
            //         _selectedPlatform = platform;
            //       });
            //     }
            //   },
            //   platforms: _platforms, // ✅ Ensure the list is passed
            // ),
            CustomSearchBar(
              controller: _controller,
              onSearch: _search, // ✅ Ensure this function is passed
              selectedPlatform: _selectedPlatform,
              onPlatformChanged: (String? platform) {
                if (platform != null) {
                  setState(() {
                    _selectedPlatform = platform;
                  });
                }
              },
              platforms: _platforms, // ✅ Ensure the list is passed
            ),
            PlatformTabs(tabController: _tabController, platforms: _platforms),
            if (_isLoading)
              Expanded(
                child: LoadingIndicator(selectedPlatform: _selectedPlatform),
              )
            else if (_results.isEmpty)
              Expanded(child: EmptyState(selectedPlatform: _selectedPlatform))
            else
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAllResults(),
                    _buildPlatformResults('YouTube', _results['youtube']),
                    _buildPlatformResults('Google', _results['google']),
                    _buildPlatformResults('Reddit', _results['reddit']),
                    _buildPlatformResults('Instagram', _results['instagram']),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllResults() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (_results['youtube']?.isNotEmpty ?? false)
          PlatformSection(
            title: 'YouTube',
            items: _results['youtube'],
            onItemTap: _launchUrl,
          ),
        if (_results['google']?.isNotEmpty ?? false)
          PlatformSection(
            title: 'Google',
            items: _results['google'],
            onItemTap: _launchUrl,
          ),
        if (_results['reddit']?.isNotEmpty ?? false)
          PlatformSection(
            title: 'Reddit',
            items: _results['reddit'],
            onItemTap: _launchUrl,
          ),
        if (_results['instagram']?.isNotEmpty ?? false)
          PlatformSection(
            title: 'Instagram',
            items: _results['instagram'],
            onItemTap: _launchUrl,
          ),
      ],
    );
  }

  Widget _buildPlatformResults(String platform, List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getPlatformIcon(platform),
              size: 60,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No $platform results found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder:
          (context, index) => ResultCard(
            item: items[index],
            source: platform,
            index: index,
            onTap: () => _launchUrl(platform, items[index]),
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
        return Icons.photo_camera_rounded;
      default:
        return Icons.search_rounded;
    }
  }
}
