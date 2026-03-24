import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/QRScannerPage.dart';
import '../user/consentScreen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _scanQr() async {
    final result = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const QRScannerPage()));
    if (result != null && result.isNotEmpty) {
      Get.to(ConsentScreen(userDataJson: result));
    } else {
      Get.snackbar("Error Occured","Something went wrong try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  'To create an account, the treasurer must first create your details through the application. And you will scan QR code from his phone to confirm your account. ',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  const SizedBox(height: 20),
                  //add a button of scanning
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _scanQr,
                      child: Text(
                        "Scan QR code",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
