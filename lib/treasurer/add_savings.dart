import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ugandamartyrssacco/common/generateQrCode.dart';

import '../db/db_services.dart';

class AddSavings extends StatefulWidget {
  const AddSavings({super.key});

  @override
  State<AddSavings> createState() => _AddSavingsState();
}

class _AddSavingsState extends State<AddSavings> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  DatabaseService db = DatabaseService();

  String selectedName = '';
  List<String> members = [];
  List<String> originalList = [];
  List<String> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = members;

    db.getMembers().then((List<Map<String, dynamic>> value) {
        originalList = value.cast<String>().toList();
      setState(() {
        members = value
            .map((row) {
              final first = (row['firstname'] ?? '').toString().trim();
              final last = (row['surname'] ?? '').toString().trim();
              final full = [
                first,
                last,
              ].where((part) => part.isNotEmpty).join(' ');
              return full;
            })
            .where((name) => name.isNotEmpty)
            .toList();
        filteredMembers = members;
      });
    });
  }

  void _filterMembers(String query) {
    setState(() {
      filteredMembers = members
          .where((member) => member.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showSearchDialog() {
    _searchController.clear();
    filteredMembers = members;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Member'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _filterMembers(value);
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredMembers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredMembers[index]),
                            onTap: () {
                              setState(() {
                                selectedName = filteredMembers[index];
                                _nameController.text = selectedName;
                              });
                              Get.snackbar("title", selectedName);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _saveRecord() async {
    int userId = 1;
    if (_nameController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      //begin by saving the new savings
      int result = await db.insertSavings(
        userId,
        double.parse(_amountController.text),
        DateTime.now().toString(),
      );
      if (result > 0) {
        // fetch savings
        List<Map<String, dynamic>> savings = await db.getSavings();

        // fetch members
        List<Map<String, dynamic>> members = await db.getMembers();

        Map<String, dynamic> formdata = {
          "user_id": userId,
          "savings": savings,
          "members": members,
        };

        Get.to(
          GenerateQrCode(
            data: jsonEncode(formdata),
            title: "Scan QR code to Update Savings",
          ),
        );
      } else {
        Get.snackbar("Error", "Failed to save savings record");
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Savings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                readOnly: true,
                onTap: _showSearchDialog,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                    return 'Please select a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: const Icon(Icons.money),
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
                    return 'Please enter amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveRecord,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Save New Record",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
