import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class PerformanceMetricsScreen extends StatefulWidget {
  const PerformanceMetricsScreen({super.key});

  @override
  State<PerformanceMetricsScreen> createState() => _PerformanceMetricsScreenState();
}

class _PerformanceMetricsScreenState extends State<PerformanceMetricsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text('System Diagnostics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildGauge('CPU Load', 0.23, AppTheme.saffron)),
                const SizedBox(width: 16),
                Expanded(child: _buildGauge('Memory', 0.45, AppTheme.green)),
              ],
            ),
            const SizedBox(height: 24),
            _buildNetworkLatency(),
            const SizedBox(height: 24),
            _buildLogStream(),
          ],
        ),
      ),
    );
  }

  Widget _buildGauge(String label, double value, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOutCubic,
              builder: (context, val, _) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: val,
                      strokeWidth: 8,
                      backgroundColor: color.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                    Center(
                      child: Text(
                        '${(val * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.navyBlue,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.navyBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkLatency() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Network Latency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ping to API Server:', style: TextStyle(color: AppTheme.navyBlue)),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final ping = 24 + (_controller.value * 12).toInt();
                  return Text(
                    '${ping}ms',
                    style: const TextStyle(color: AppTheme.green, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.1,
            backgroundColor: Color(0xFFEEEEEE),
            valueColor: AlwaysStoppedAnimation(AppTheme.green),
          ),
        ],
      ),
    );
  }

  Widget _buildLogStream() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10141D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            String timestamp = DateTime.now().toIso8601String().substring(11, 23);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logLine('[OK] Models loaded successfully', Colors.green),
                _logLine('[INFO] Hive box opened', Colors.blue),
                _logLine('[INFO] Connection to Firebase established', Colors.blue),
                _logLine('[WARN] Skipping frame (60fps target missed)', Colors.orange),
                _logLine('[$timestamp] System heartbeat OK', Colors.white),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _logLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12)),
    );
  }
}
