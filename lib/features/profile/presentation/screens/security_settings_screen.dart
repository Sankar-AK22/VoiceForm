import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> with SingleTickerProviderStateMixin {
  bool _faceIdEnabled = true;
  bool _pinEnabled = false;
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Biometric Security'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildFaceIdScanner(),
            const SizedBox(height: 40),
            _buildSettingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdScanner() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: AppTheme.saffron.withOpacity(0.3),
            width: 4,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.face_retouching_natural_rounded,
              size: 100,
              color: AppTheme.navyBlue,
            ),
            // Animated scanner bar
            AnimatedBuilder(
              animation: _scanController,
              builder: (context, child) {
                return Positioned(
                  top: _scanController.value * 160,
                  child: Container(
                    width: 180,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.green,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.green.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ).animate().shimmer(duration: 2.seconds, color: AppTheme.saffron.withOpacity(0.2)),
    );
  }

  Widget _buildSettingsList() {
    return GlassCard(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          _buildSwitchTile(
            title: 'Face ID Unlocking',
            subtitle: 'Use face scan to open app',
            value: _faceIdEnabled,
            onChanged: (val) => setState(() => _faceIdEnabled = val),
            icon: Icons.face_rounded,
            iconColor: AppTheme.saffron,
          ),
          Divider(color: AppTheme.navyBlue.withOpacity(0.1), height: 1),
          _buildSwitchTile(
            title: 'PIN Fallback',
            subtitle: 'Require 6-digit PIN if scan fails',
            value: _pinEnabled,
            onChanged: (val) => setState(() => _pinEnabled = val),
            icon: Icons.pin_rounded,
            iconColor: AppTheme.green,
          ),
          Divider(color: AppTheme.navyBlue.withOpacity(0.1), height: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.password_rounded, color: Colors.red),
            ),
            title: const Text('Change Master Password', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navyBlue)),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color iconColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navyBlue)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: AppTheme.navyBlue.withOpacity(0.6))),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.green,
      ),
    );
  }
}
