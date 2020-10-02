import 'package:flutter_test/flutter_test.dart';
import 'package:times_table/Pages/multiplication_page.dart';

import '../utils/exception_utils.dart';
import '../utils/widget_utils.dart';

void main() {
  testWidgets('shows Multiplication Table Page', (WidgetTester tester) async {
    await pumpWidget(tester, MultiplicationTablePage('my title'));
    expect(find.byType(MultiplicationTablePage), findsOneWidget);
  });

  testWidgets('shows My title', (WidgetTester tester) async {
    var title = 'My Title';
    await pumpWidget(tester, MultiplicationTablePage(title));
    expect(find.text(title), findsOneWidget);
  });

  [null, ''].forEach((element) {
    testWidgets('"$element" title throws ArgumentError',
        (WidgetTester tester) async {
      expectException<ArgumentError>(() => MultiplicationTablePage(null));
    });
  });
}
