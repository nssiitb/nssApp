import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AttendanceAA extends StatefulWidget {
  const AttendanceAA({super.key});

  @override
  State<AttendanceAA> createState() => _AttendanceAA();
}

class _AttendanceAA extends State<AttendanceAA> {
  final _formKey = GlobalKey<FormState>();

  String? name, Nssdepartment,   location;
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
  final List<String> Nssdepartments = ['Educational outreach', 'social Development', 'Campus Engagement','Environment and Sustainabilty' ];
 

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
          
                  const SizedBox(height: 10),
                  const Text("NssDepartment:"),
                  DropdownButtonFormField<String>(
                    value: Nssdepartments[0],
                    items: Nssdepartments.map((dep) => DropdownMenuItem(value: dep, child: Text(dep))).toList(),
                    onChanged: (val) => Nssdepartment = val,
                  ),

                  const SizedBox(height: 10),
                  
                  
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
                           
                            'Nssdepartment': Nssdepartment,
                        
                          'location': location,
                          });
                        }
                      },
                      child: const Text('Login'),
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


