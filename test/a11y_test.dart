import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:veil_wallet/src/layouts/mobile/back_layout.dart';
import 'package:veil_wallet/src/states/states_bridge.dart';

void main() {
  testWidgets('Test accessibility', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    var lightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: const Color.fromARGB(255, 35, 89, 247),
      surface: const Color.fromARGB(255, 233, 239, 247),
    );
    await tester.pumpWidget(MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        navigatorKey: StatesBridge.navigatorKey,
        home: const BackLayout(
          title: 'test',
          child: Text('test'),
        )));

// Checks that tappable nodes have a minimum size of 48 by 48 pixels
// for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

// Checks that tappable nodes have a minimum size of 44 by 44 pixels
// for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

// Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

// Checks whether semantic nodes meet the minimum text contrast levels.
// The recommended text contrast is 3:1 for larger text
// (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
