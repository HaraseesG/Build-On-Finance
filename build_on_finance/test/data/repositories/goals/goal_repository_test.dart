import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/goals/goal_repository.dart';
import 'package:build_on_finance/models/goals/goal.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late GoalRepository repository;

  setUpAll(() {
    dbHelper = initTestDb();
    repository = GoalRepository(dbHelper: dbHelper);
  });

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  group('GoalRepository', () {
    test('insert then getById returns the same goal', () async {
      final id = await repository.insert(
        Goal(name: 'Wedding', targetAmount: 15000.0),
      );

      final fetched = await repository.getById(id);

      expect(fetched, isNotNull);
      expect(fetched!.name, 'Wedding');
      expect(fetched.targetAmount, 15000.0);
    });

    test('getById returns null for a non-existent id', () async {
      final fetched = await repository.getById(9999);
      expect(fetched, isNull);
    });

    test('getAll returns every inserted goal', () async {
      await repository.insert(Goal(name: 'Wedding', targetAmount: 15000.0));
      await repository.insert(
        Goal(name: 'House down payment', targetAmount: 50000.0),
      );

      final all = await repository.getAll();
      expect(all.length, 2);
    });

    test('update modifies an existing goal', () async {
      final id = await repository.insert(
        Goal(name: 'Wedding', targetAmount: 15000.0),
      );
      final original = await repository.getById(id);

      await repository.update(original!.copyWith(targetAmount: 18000.0));

      final fetched = await repository.getById(id);
      expect(fetched!.targetAmount, 18000.0);
    });

    test('Delete removes the goal', () async {
      final id = await repository.insert(
        Goal(name: 'Wedding', targetAmount: 15000.0),
      );
      await repository.delete(id);

      final fetched = await repository.getById(id);
      expect(fetched, isNull);
    });

    test('supports an optional target date', () async {
      final targetDate = DateTime(2027, 6, 1);
      final id = await repository.insert(
        Goal(name: 'Wedding', targetAmount: 15000.0, targetDate: targetDate),
      );

      final fetched = await repository.getById(id);
      expect(fetched!.targetDate, targetDate);
    });
  });
}
