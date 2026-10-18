import 'package:flutter_test/flutter_test.dart';

import 'package:build_on_finance/main.dart';

void main() {
  testWidgets('app boots and renders the placeholder home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BuildOnFinanceApp());

    expect(find.text('Build On Finance'), findsOneWidget);
  });
}
