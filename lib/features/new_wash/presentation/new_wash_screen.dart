import 'package:flutter/material.dart';
import '../../../shared/widgets/empty_state_card.dart';

/// New wash destination shell providing an entry point for wash creation.
class NewWashScreen extends StatelessWidget {
  const NewWashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Wash'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          EmptyStateCard(
            icon: Icons.add_circle_outline_rounded,
            title: 'Create a New Wash Batch',
            description:
                'Set up your laundry items by category, configure your wash date, and set an expected retrieval date.',
            action: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Wash form setup will be available in the next phase.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.playlist_add),
              label: const Text('New Wash'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Category Counter Preview',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'In upcoming phases, you will be able to track items including Shirts, T-Shirts, Jeans, Trousers, Undergarments, and more with automatic limit checking and color-coded counts.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
