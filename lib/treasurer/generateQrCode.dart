import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ugandamartyrssacco/treasurer/dashboard.dart';

class GenerateQrCode extends StatefulWidget {
  final String data;

  const GenerateQrCode({super.key, required this.data});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  late String qrData;
  Map? decodedData;

  @override
  void initState() {
    super.initState();
    qrData = widget.data;
    decodedData = jsonDecode(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Member QR Code',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This Code belongs to ${decodedData?['firstName']} ${decodedData?['surname']} . Scan this code to be logged in as a member on the members app",
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 240.0,
                    gapless: false,
                    errorStateBuilder: (context, error) {
                      return Center(
                        child: Text(
                          'Error generating QR Code\n$error',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(TreasurerDashboard());
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
