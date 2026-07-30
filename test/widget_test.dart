import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maldives_experts_customer/app.dart';
import 'package:maldives_experts_customer/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('shows splash then opens login after three seconds', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const MaldivesExpertsApp(),
      ),
    );

    expect(find.text('Your Dream Holiday'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
