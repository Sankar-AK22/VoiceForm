import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNotification(
            icon: Icons.check_circle_outline,
            color: AppTheme.green,
            title: 'Survey Success',
            body: 'Your survey "Retail Staff Review" collected 50 responses.',
            time: '2 mins ago',
            isNew: true,
          ),
          _buildNotification(
            icon: Icons.cloud_done_outlined,
            color: AppTheme.saffron,
            title: 'Cloud Sync Complete',
            body: 'App successfully backed up offline forms to the server.',
            time: '1 hour ago',
            isNew: true,
          ),
          _buildNotification(
            icon: Icons.warning_amber_rounded,
            color: Colors.red,
            title: 'Low Storage Warning',
            body: 'You are running out of local storage. Clear offline cache.',
            time: 'Yesterday',
            isNew: false,
          ),
          _buildNotification(
            icon: Icons.group_add_outlined,
            color: AppTheme.navyBlue,
            title: 'New Teammate',
            body: 'Priya joined your organization.',
            time: '3 days ago',
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotification({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
    required String time,
    required bool isNew,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: isNew ? FontWeight.bold : FontWeight.w500,
                          color: AppTheme.navyBlue,
                          fontSize: 16,
                        ),
                      ),
                      Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: TextStyle(color: AppTheme.navyBlue.withOpacity(0.7), fontSize: 14),
                  ),
                ],
              ),
            ),
            if (isNew)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(left: 8, top: 4),
                decoration: const BoxDecoration(
                  color: AppTheme.saffron,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
