import 'package:floor/floor.dart';

import 'Person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Stream<List<Person>> findAll();

  @insert
  Future<void> addPerson(Person person);
}
