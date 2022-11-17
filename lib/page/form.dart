import 'package:pbp_lab06/main.dart';
import 'package:pbp_lab06/page/to_do_page.dart';
import 'package:flutter/material.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = "";
  bool undergraduateDegree = false;
  bool diplomaDegree = false;
  bool masterDegree = false;
  bool doctorDegree = false;
  String Degree = "";
  double age = 0;
  String pdbClass = 'KI';
  List<String> listPBDClass = ['A', 'B', 'C', 'D', 'E', 'F', 'KI'];
  bool _switchValue = false;

  void Rank() {
    setState(() {
      if (undergraduateDegree) {
        Degree = "undergraduate" ;
      } else if (diplomaDegree) {
        Degree = "Diploma";
      } else if (undergraduateDegree) {
        Degree = "masterDegree";
      } else if (undergraduateDegree) {
        Degree = "doctorDegree";
      } else {
        Degree = "Not choose";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Adding clickable menu
            ListTile(
              title: const Text('Counter'),
              onTap: () {
                // Routing the menu to the main page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                // Routing the menu to the form page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFormPage()),
                );
              },
            ),
            ListTile(
              title: const Text('To Do'),
              onTap: () {
                // Route the menu to the to do page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ToDoPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Form(key: _formKey, child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                // Using padding of 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Example: Pak Dengklek",
                    labelText: "Full Name",
                    // Add icons to make it more intuitive
                    icon: const Icon(Icons.people),
                    // Added a circular border to make it neater
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Added behavior when name is typed
                  onChanged: (String? value) {
                    setState(() {
                      _fullName = value!;
                    });
                  },
                  // Added behavior when data is saved
                  onSaved: (String? value) {
                    setState(() {
                      _fullName = value!;
                    });
                  },
                  // Validator as form validation
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      leading:  Icon(Icons.school),
                      title: Text("Degree"),
                    ),
                    CheckboxListTile(
                      title: const Text('Undergraduate'),
                      value: undergraduateDegree,
                      onChanged: (bool? value) {
                        setState(() {
                          undergraduateDegree = value!;
                          if (value){
                            masterDegree = diplomaDegree = doctorDegree = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Diploma'),
                      value: diplomaDegree,
                      onChanged: (bool? value) {
                        setState(() {
                          diplomaDegree = value!;
                          if (value){
                            masterDegree = undergraduateDegree = doctorDegree = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Master'),
                      value: masterDegree,
                      onChanged: (bool? value) {
                        setState(() {
                          masterDegree = value!;
                          if (value){
                            diplomaDegree = undergraduateDegree = doctorDegree = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Doctor'),
                      value: doctorDegree,
                      onChanged: (bool? value) {
                        setState(() {
                          doctorDegree = value!;
                          if (value){
                            masterDegree = undergraduateDegree = diplomaDegree = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.co_present),
                title: Row(
                  children: [
                    Text('Age: ${age.round()}'),
                  ],
                ),
                subtitle: Slider(
                  value: age,
                  max: 100,
                  divisions: 100,
                  label: age.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.class_),
                title: const Text(
                  'PBD Class',
                ),
                trailing: DropdownButton(
                  value: pdbClass,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: listPBDClass.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      pdbClass = newValue!;
                    });
                  },
                ),
              ),
              SwitchListTile(
                title: const Text('Practice Mode'),
                value: _switchValue,
                onChanged: (bool value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
                secondary: const Icon(Icons.run_circle_outlined),
              ),
              TextButton(
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                          child: Container(
                            child: ListView(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              shrinkWrap: true,
                              children: <Widget>[
                                // TODO: Display the information obtained from the form
                                Center(child: Text('Informasi Data'+ '\n')),
                                Center(child: Text('FullName: ' + _fullName +'\n')),
                                Center(child: Text('Degree' + Degree + '\n')),
                                Center(child: Text('Age' + age.toString() + '\n')),
                                Center(child: Text('Class: ' + pdbClass + '\n')),
                                Center(child: Text('Practice: ' + _switchValue.toString() + '\n')),
                                SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Kembali'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )
      )
    );
  }
}