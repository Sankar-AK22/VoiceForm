import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vani_sahayak/main.dart';

void main() {
  testWidgets('App launches and displays placeholder home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: VoiceFormApp()));

    // Verify that the app title is displayed
    expect(find.text('VoiceForm'), findsWidgets);
  });
}
