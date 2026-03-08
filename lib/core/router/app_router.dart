import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/survey/presentation/screens/survey_list_screen.dart';
import '../../features/survey/presentation/screens/create_survey_screen.dart';
import '../../features/survey/presentation/screens/scan_form_screen.dart';
import '../../features/survey/presentation/screens/voice_recording_screen.dart';
import '../../features/survey/presentation/screens/review_screen.dart';
import '../../features/survey/presentation/screens/pdf_preview_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';

// Premium Features
import '../../features/dashboard/presentation/screens/analytics_screen.dart';
import '../../features/survey/presentation/screens/vani_chat_screen.dart';
import '../../features/home/presentation/screens/sync_manager_screen.dart';
import '../../features/profile/presentation/screens/security_settings_screen.dart';
import '../../features/profile/presentation/screens/performance_metrics_screen.dart';
import '../../features/dashboard/presentation/screens/data_export_screen.dart';
import '../../features/profile/presentation/screens/collaborator_invite_screen.dart';
import '../../features/home/presentation/screens/notification_center_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/surveys',
        builder: (context, state) => const SurveyListScreen(),
      ),
      GoRoute(
        path: '/create-survey',
        builder: (context, state) => const CreateSurveyScreen(),
      ),
      GoRoute(
        path: '/scan-form',
        builder: (context, state) => const ScanFormScreen(),
      ),
      GoRoute(
        path: '/voice-recording/:sessionId',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return VoiceRecordingScreen(sessionId: sessionId);
        },
      ),
      GoRoute(
        path: '/review/:sessionId',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return ReviewScreen(sessionId: sessionId);
        },
      ),
      GoRoute(
        path: '/pdf-preview/:sessionId',
        builder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return PDFPreviewScreen(sessionId: sessionId);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      // Advanced Premium Screens
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/vani-chat',
        builder: (context, state) => const VaniChatScreen(),
      ),
      GoRoute(
        path: '/sync-manager',
        builder: (context, state) => const SyncManagerScreen(),
      ),
      GoRoute(
        path: '/security',
        builder: (context, state) => const SecuritySettingsScreen(),
      ),
      GoRoute(
        path: '/performance',
        builder: (context, state) => const PerformanceMetricsScreen(),
      ),
      GoRoute(
        path: '/export',
        builder: (context, state) => const DataExportScreen(),
      ),
      GoRoute(
        path: '/collaborators',
        builder: (context, state) => const CollaboratorInviteScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationCenterScreen(),
      ),
    ],
  );
});
