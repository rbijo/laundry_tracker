import 'package:flutter/material.dart';
import '../../../shared/widgets/empty_state_card.dart';
import '../../../shared/widgets/section_header.dart';

/// Home destination shell showing user greeting, in progress washes, and completed summary.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.onStartNewWash,
  });

  final VoidCallback? onStartNewWash;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Tracker'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          // Greeting Banner
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    radius: 24,
                    child: const Icon(Icons.person),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Robin!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Keep track of your active laundry loads easily.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // In Progress Section
          const SectionHeader(
            title: 'In Progress',
            subtitle: 'Active wash batches currently being cleaned or processed',
          ),
          EmptyStateCard(
            icon: Icons.local_laundry_service_outlined,
            title: 'No active washes',
            description: 'You currently have no washes in progress. Start a new wash batch when you are ready.',
            action: FilledButton.tonalIcon(
              onPressed: onStartNewWash,
              icon: const Icon(Icons.add),
              label: const Text('Start New Wash'),
            ),
          ),
          const SizedBox(height: 20),

          // Completed Summary Section
          const SectionHeader(
            title: 'Completed Washes',
            subtitle: 'Summary of finished and tracked laundry batches',
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryMetric(
                      context: context,
                      label: 'Total Completed',
                      value: '0',
                      icon: Icons.done_all,
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: _buildSummaryMetric(
                      context: context,
                      label: 'Successfully Tracked',
                      value: '0',
                      icon: Icons.verified_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
