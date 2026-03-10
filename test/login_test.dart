import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ugandamartyrssacco/auth/login.dart';

void main() {
  setUp(() {
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Login widget renders correctly', (WidgetTester tester) async {
    // Build the Login widget
    await tester.pumpWidget(const GetMaterialApp(
      home: Login(),
    ));

    // Verify that the welcome text is displayed
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login to your account'), findsOneWidget);

    // Verify that the form fields are present
    expect(find.byType(TextFormField), findsNWidgets(2)); // Phone and password
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify that the login button is present
    expect(find.text('Login'), findsOneWidget);

    // Verify that the signup link is present
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('Login form validation works', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: Login(),
    ));

    // Tap the login button without entering anything
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify validation errors
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Phone number validation', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: Login(),
    ));

    // Enter short phone number
    await tester.enterText(find.byType(TextFormField).first, '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter a valid phone number'), findsOneWidget);
  });

  testWidgets('Password validation', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: Login(),
    ));

    // Enter short password
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Successful login with correct password', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(
      home: Login(),
    ));

    // Enter valid phone and password
    await tester.enterText(find.byType(TextFormField).first, '+256700000000');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Since Get.to is mocked, we can't easily test navigation
    // But we can check that no validation errors are shown
    expect(find.text('Please enter your phone number'), findsNothing);
    expect(find.text('Please enter your password'), findsNothing);
  });
}