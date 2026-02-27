import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _qrController = TextEditingController();


  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _qrController.dispose();
    super.dispose();
  }

  Future<void> _scanQr() async {
    final result = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const QRScannerPage()));
    if (result != null && result.isNotEmpty) {
      setState(() {
        _qrController.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  'To create an account, the treasurer must first create your details through the application. And you will scan QR code from his phone to confirm your account. ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: _scanQr,
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

// simple dedicated scanner page to return QR code result
class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );
  bool _isScanning = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          final String? code = barcode.rawValue;
          if (code != null && _isScanning) {
            _isScanning = false;
            Navigator.of(context).pop(code);
          }
        },
      ),
    );
  }
}
