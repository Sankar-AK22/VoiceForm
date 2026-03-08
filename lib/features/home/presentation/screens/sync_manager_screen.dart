import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class SyncManagerScreen extends StatefulWidget {
  const SyncManagerScreen({super.key});

  @override
  State<SyncManagerScreen> createState() => _SyncManagerScreenState();
}

class _SyncManagerScreenState extends State<SyncManagerScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10141D), // Dark mode specifically for sync!
      appBar: AppBar(
        title: const Text('Live Sync Engine', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildCentralOrb(),
              const SizedBox(height: 60),
              _buildSyncStatsRow(),
              const SizedBox(height: 40),
              _buildStatusList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCentralOrb() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glowing ring
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              width: 250 + (_pulseController.value * 20),
              height: 250 + (_pulseController.value * 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.saffron.withOpacity(0.0),
                    AppTheme.saffron.withOpacity(0.1 + (_pulseController.value * 0.1)),
                  ],
                ),
              ),
            );
          },
        ),
        // Spinning dashed ring
        AnimatedBuilder(
          animation: _spinController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _spinController.value * 2 * 3.14159,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.saffron.withOpacity(0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            );
          },
        ),
        // Inner ball
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppTheme.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppTheme.saffron.withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_sync_rounded, color: Colors.white, size: 40),
              SizedBox(height: 8),
              Text(
                'SYNCING',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ).animate().shimmer(duration: 2.seconds, delay: 1.seconds),
      ],
    );
  }

  Widget _buildSyncStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('14', 'Pending', Colors.white),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.1)),
          _buildStatColumn('3.2 MB/s', 'Speed', AppTheme.saffronLight),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.1)),
          _buildStatColumn('1,402', 'Synced', AppTheme.greenLight),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String val, String label, Color color) {
    return Column(
      children: [
        Text(
          val,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'IN PROGRESS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildQueueItem('Survey_Health_24.pdf', 'Uploading...', 0.7, AppTheme.saffron),
        _buildQueueItem('Audio_Session_091.wav', 'Compressing...', 0.3, AppTheme.green),
        _buildQueueItem('Metadata_Batch_4.json', 'Completed', 1.0, Colors.grey.withOpacity(0.5)),
      ],
    );
  }

  Widget _buildQueueItem(String name, String status, double progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              Text(status, style: TextStyle(color: color, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.1, end: 0);
  }
}
