import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class DataExportScreen extends StatefulWidget {
  const DataExportScreen({super.key});

  @override
  State<DataExportScreen> createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {
  bool _isExporting = false;
  double _exportProgress = 0.0;
  bool _exportDone = false;

  void _startExport() {
    setState(() {
      _isExporting = true;
      _exportProgress = 0.0;
      _exportDone = false;
    });

    _simulateExport();
  }

  void _simulateExport() async {
    for (int i = 1; i <= 100; i += 2) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
      setState(() {
        _exportProgress = i / 100.0;
      });
    }
    setState(() {
      _isExporting = false;
      _exportDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text('Export Data')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.file_download_outlined, size: 80, color: AppTheme.navyBlue),
              const SizedBox(height: 24),
              const Text(
                'Generate Report',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.navyBlue),
              ),
              const SizedBox(height: 8),
              const Text(
                'Export all surveyed data into a combined CSV or PDF report format.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 40),
              if (_exportDone)
                _buildSuccessMessage()
              else if (_isExporting)
                _buildExportingUI()
              else
                _buildExportButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return GestureDetector(
      onTap: _startExport,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.saffron.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Text('Start Export', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildExportingUI() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text('Archiving Files... (${(_exportProgress * 100).toInt()}%)', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _exportProgress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation(AppTheme.saffron),
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: AppTheme.green, size: 40),
        ),
        const SizedBox(height: 16),
        const Text('Export Completed!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.green)),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            setState(() => _exportDone = false);
          },
          child: const Text('Export Another', style: TextStyle(color: AppTheme.navyBlue)),
        ),
      ],
    );
  }
}
