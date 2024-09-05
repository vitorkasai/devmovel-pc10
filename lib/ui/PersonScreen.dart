import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../persistence/Person.dart';
import '../viewmodels/PersonViewModel.dart';

class PersonScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final personViewModel = Provider.of<PersonViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing persons'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightBlue, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Age',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.lightBlue, width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text;
                      final age = int.parse(_ageController.text);
                      personViewModel.addPerson(name, age);
                      _nameController.clear();
                      _ageController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text('Add new Person'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Person>>(
                stream: personViewModel.personsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No persons found'));
                  } else {
                    final persons = snapshot.data!;
                    return ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        final person = persons[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(person.name),
                            subtitle: Text('Age: ${person.age}'),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
