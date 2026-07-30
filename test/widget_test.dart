import 'package:flutter_test/flutter_test.dart';
import 'package:maldives_experts_customer/app.dart';
import 'package:maldives_experts_customer/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('shows splash branding', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const MaldivesExpertsApp(),
      ),
    );

    expect(find.text('Maldives Experts'), findsOneWidget);
  });
}
