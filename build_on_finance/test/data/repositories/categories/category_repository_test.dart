import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/categories/category_repository.dart';
import 'package:build_on_finance/models/categories/category.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late CategoryRepository repository;

  setUpAll(() {
    dbHelper = initTestDb();
    repository = CategoryRepository(dbHelper: dbHelper);
  });

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  group('CategoryRepository', () {
    test('insert then getById returns the same category', () async {
      final id = await repository.insert(
        Category(name: 'Groceries', budgetMonthly: 400.0),
      );

      final fetched = await repository.getById(id);

      expect(fetched, isNotNull);
      expect(fetched!.name, 'Groceries');
      expect(fetched.budgetMonthly, 400.0);
    });

    test('getById returns null for a non-existent id', () async {
      final fetched = await repository.getById(9999);
      expect(fetched, isNull);
    });

    test('getAll returns every inserted category', () async {
      await repository.insert(Category(name: 'Groceries'));
      await repository.insert(Category(name: 'Gas'));

      final all = await repository.getAll();

      expect(all.length, 2);
      expect(all.map((c) => c.name), containsAll(['Groceries', 'Gas']));
    });

    test('Update modifies an existing category', () async {
      final id = await repository.insert(Category(name: 'Groceries'));
      final original = await repository.getById(id);

      await repository.update(original!.copyWith(budgetMonthly: 500.0));

      final fetched = await repository.getById(id);
      expect(fetched!.budgetMonthly, 500.0);
    });

    test('delete removes the category', () async {
      final id = await repository.insert(Category(name: 'Groceries'));
      await repository.delete(id);

      final fetched = await repository.getById(id);
      expect(fetched, isNull);
    });

    test('supports a subcategory via parent_id', () async {
      final parentId = await repository.insert(Category(name: 'Food'));
      final childId = await repository.insert(
        Category(name: 'Restaurants', parentId: parentId),
      );

      final child = await repository.getById(childId);
      expect(child!.parentId, parentId);
    });
  });
}
