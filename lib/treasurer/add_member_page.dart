import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:ugandamartyrssacco/treasurer/dashboard.dart';
import 'package:ugandamartyrssacco/treasurer/generateQrCode.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _registerMember() {
    if (_formKey.currentState!.validate()) {
      // Create member data as JSON
      final memberData = {
        'firstName': _firstNameController.text,
        'surname': _surnameController.text,
        'address': _addressController.text,
        'phoneNumber': _phoneNumberController.text,
      };

      // Convert to JSON string
      final jsonString = jsonEncode(memberData);

      // Navigate to QR code generation with JSON data
      Get.to(GenerateQrCode(data: jsonString));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(TreasurerDashboard());
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Register New Member",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First Name Field
                    TextFormField(
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    // Surname Field
                    TextFormField(
                      controller: _surnameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter surname';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    // Address Field
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: const Icon(Icons.location_on),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    // Phone Number Field
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registerMember,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Generate QR Code",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
