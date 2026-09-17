import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/categories/category_repository.dart';
import 'package:build_on_finance/data/seed/categories/category_seeder.dart';
import 'package:build_on_finance/data/seed/categories/default_categories.dart';
import 'package:build_on_finance/models/categories/category.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late CategoryRepository categoryRepository;
  late CategorySeeder seeder;

  int expectedCategoryCount() =>
      defaultCategories.length +
      defaultCategories.values.fold<int>(
        0,
        (sum, children) => sum + children.length,
      );

  setUpAll(() {
    dbHelper = initTestDb();
    categoryRepository = CategoryRepository(dbHelper: dbHelper);
    seeder = CategorySeeder(categoryRepository: categoryRepository);
  });

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  test('seed() inserts every parent and child category', () async {
    await seeder.seed();
    final all = await categoryRepository.getAll();
    expect(all.length, expectedCategoryCount());
  });

  test('child categories are linked to correct parentId', () async {
    await seeder.seed();
    final all = await categoryRepository.getAll();

    final housing = all.firstWhere((c) => c.name == 'Housing');
    final rent = all.firstWhere((c) => c.name == 'Rent/Mortgage');

    expect(rent.parentId, housing.id);
  });

  test('seed() called twice does not duplicate rows', () async {
    await seeder.seed();
    await seeder.seed();

    final all = await categoryRepository.getAll();
    expect(all.length, expectedCategoryCount());
  });

  test(
    'seed() fills in missing children without duplicating existing ones',
    () async {
      final housingId = await categoryRepository.insert(
        Category(name: 'Housing', parentId: null, budgetMonthly: null),
      );
      await categoryRepository.insert(
        Category(
          name: 'Rent/Mortgage',
          parentId: housingId,
          budgetMonthly: null,
        ),
      );

      await seeder.seed();

      final all = await categoryRepository.getAll();
      expect(all.length, expectedCategoryCount());
      expect(all.where((c) => c.name == 'Rent/Mortgage').length, 1);
      expect(all.where((c) => c.name == 'Housing').length, 1);
      expect(all.where((c) => c.parentId == housingId).length, 4);
    },
  );
}
