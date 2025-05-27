import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nssapp/utils/authenticator.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // readonly value of text field
  bool _isReadOnly = true;
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  String? rollNo;
  String? name;
  String? phone;
  String? email;
  String? dept;

  void fetchToken() async {
    final AuthService authService = AuthService();
    Map<String, dynamic>? token = await authService.getToken();
    if (token != null) {
      setState(() {
        rollNo = token['roll'];
        name = token['name'];
        phone = token['mobile'];
        email = token['email'];
        dept = token['dept'];
        _nameController.text = name ?? "";
        _rollNumberController.text = rollNo ?? "";
        _phoneController.text = phone ?? "";
        _emailController.text = email ?? "";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login session expired"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void modifyUser() async {
    var body = {
      "name": _nameController.text,
      "rollNo": _rollNumberController.text,
      "phone": _phoneController.text,
      "email": _emailController.text,
    };

    print("data sent: ");
    print(body);

    var response = await http.post(Uri.parse("http://10.59.5.175:3000/modify"),
        headers: {"Content-Type": "application/json"}, body: jsonEncode(body));

    // decode the json response
    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    // handle the response from the server
    if (jsonResponse['status']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Details modified."),
          duration: Duration(seconds: 3),
        ),
      );
      // del previous token
      await _authService.logout();
      // save the new details
      await _authService.saveToken({
        "roll": rollNo,
        "name": name,
        "mobile": phone,
        "dept": dept,
        "email": email,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsonResponse['message'] ?? "Something went wrong."),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 1, 1, 59),
                        Color.fromARGB(200, 1, 1, 59)
                      ], // Gradient color
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context); // go back to previous page
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                Positioned(
                    top: 30,
                    right: 20,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isReadOnly = !_isReadOnly;
                          });
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 25,
                          color: Colors.white,
                        ))),
                Positioned(
                  top: 115,
                  left: MediaQuery.of(context).size.width / 2 - 60,
                  child: Image.asset(
                    'assets/images/nsslogo.png',
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Name
                      Expanded(
                        child: buildTextField(
                            "Name", "$name", _nameController, false),
                      ),
                      const SizedBox(width: 20),
                      // Roll No.
                      Expanded(
                        child: buildTextField("Roll Number", "$rollNo",
                            _rollNumberController, true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  buildTextField("Email", "$email", _emailController, false),
                  const SizedBox(height: 20),
                  // Phone Field
                  buildTextField("Phone", "$phone", _phoneController, false),
                  const SizedBox(height: 20),
                  // Department Field
                  buildTextField(
                      "Department", "$dept", _departmentController, true),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            if (!_isReadOnly)
              ElevatedButton(
                  onPressed: modifyUser, child: const Text("Save Changes")),
          ],
        ),
      ),
    );
  }

  // function for building text fields
  Widget buildTextField(String label, String placeholder,
      TextEditingController controller, bool shouldNotBeChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          readOnly: shouldNotBeChanged ? true : _isReadOnly,
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
