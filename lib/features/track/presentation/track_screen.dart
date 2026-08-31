import 'package:flutter/material.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/section_header.dart';

/// Track destination shell displaying active washes and an expandable completed section.
class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Washes'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          // In Progress Active Washes Section
          const SectionHeader(
            title: 'Active Washes',
            subtitle: 'Monitor and update current washes in progress',
          ),
          const EmptyStateCard(
            icon: Icons.hourglass_empty_rounded,
            title: 'No active washes to track',
            description:
                'Active washes will appear here with options to update clothes quantity, modify wash dates, or mark items as received.',
          ),
          const SizedBox(height: 20),

          // Completed Washes Expandable Section
          Card(
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              leading: Icon(
                Icons.check_circle_outline,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'Completed Washes',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'View past wash history and tracking results',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              childrenPadding: const EdgeInsets.all(16.0),
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 40,
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No completed washes yet',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
