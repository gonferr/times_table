import 'package:flutter_test/flutter_test.dart';

import 'package:times_table/main.dart';

void main() {
  testWidgets('shows myApp', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
