import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_3/second.dart';

void main() 
{
  testWidgets('Second Test', (widgetTester) async 
  {      
      await widgetTester.pumpWidget(const Second());

      final buttonFinder = find.text("Regresar");
      expect(buttonFinder, findsOneWidget);
      await widgetTester.tap(buttonFinder);
     
      await widgetTester.pump();
  });
}