import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _Attendance();
}

class _Attendance extends State<Attendance> {
  final _formKey = GlobalKey<FormState>();

  String? name, rollNo, department, phoneNumber, aaName, location;
  Future<void> _getlocation () async {
    Future<bool> enabled =   Geolocator.isLocationServiceEnabled() ; 
    Future<LocationPermission> permission = Geolocator.checkPermission() ; 
    if (permission == LocationPermission.denied) { permission =  Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    } 

  }
  if (permission == LocationPermission.deniedForever) {
    return;
  }
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium) ; 

  }
  final List<String> departments = ['Educational outreach', 'social Development', 'Campus Engagement','Environment and Sustainabilty'];
  final List<String> aaNames = ['Select Nearby AA Name'];

  @override
  void initState() {
    super.initState();
    _getlocation() ; 
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(246, 179, 236, 184),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26)],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text('Attendance', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Name', (val) => name = val),
                  _buildTextField('Roll No', (val) => rollNo = val),
                  const SizedBox(height: 10),
                  const Text("Department:"),
                  DropdownButtonFormField<String>(
                    value: departments[0],
                    items: departments.map((dep) => DropdownMenuItem(value: dep, child: Text(dep))).toList(),
                    onChanged: (val) => department = val,
                  ),
                  _buildTextField('Phone Number', (val) => phoneNumber = val),
                  const SizedBox(height: 10),
                  const Text("AA Name:"),
                  DropdownButtonFormField<String>(
                    value: aaNames[0],
                    items: aaNames.map((aa) => DropdownMenuItem(value: aa, child: Text(aa))).toList(),
                    onChanged: (val) => aaName = val,
                  ),
                  const SizedBox(height: 10),
                  const Text("Location:"),
                  Text(location ?? 'Fetching...', style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print({
                            'name': name,
                            'rollNo': rollNo,
                            'department': department,
                            'phoneNumber': phoneNumber,
                            'aaName': aaName,
                            'location': location,
                          });
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:"),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
          onSaved: (val) => onSaved(val!),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}