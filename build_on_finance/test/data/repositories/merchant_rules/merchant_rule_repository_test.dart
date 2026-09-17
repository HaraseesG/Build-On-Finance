import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/merchant_rules/merchant_rule_repository.dart';
import 'package:build_on_finance/models/merchant_rules/merchant_rule.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late MerchantRuleRepository repository;

  setUpAll(() {
    dbHelper = initTestDb();
    repository = MerchantRuleRepository(dbHelper: dbHelper);
  });

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  group('MerchantRuleRepository', () {
    test('insert then getById returns the same rule', () async {
      final id = await repository.insert(
        MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
      );

      final fetched = await repository.getById(id);

      expect(fetched, isNotNull);
      expect(fetched!.pattern, 'TIM HORTONS');
      expect(fetched.categoryId, 1);
    });

    test('getById returns null for a non-existent id', () async {
      final fetched = await repository.getById(9999);
      expect(fetched, isNull);
    });

    test('getAll returns every inserted rule', () async {
      await repository.insert(
        MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
      );
      await repository.insert(MerchantRule(pattern: 'AMZN', categoryId: 2));

      final all = await repository.getAll();
      expect(all.length, 2);
      expect(all.map((mr) => mr.pattern), containsAll(['TIM HORTONS', 'AMZN']));
    });

    test('update modifies an existing rule', () async {
      final id = await repository.insert(
        MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
      );
      final original = await repository.getById(id);

      await repository.update(original!.copyWith(categoryId: 5));

      final fetched = await repository.getById(id);
      expect(fetched!.categoryId, 5);
    });

    test('delete removes the rule', () async {
      final id = await repository.insert(
        MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
      );
      await repository.delete(id);

      final fetched = await repository.getById(id);
      expect(fetched, isNull);
    });

    test(
      'findMatchFor matches a pattern contained in the merchant string',
      () async {
        await repository.insert(
          MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
        );

        final match = await repository.findMatchFor('TIM HORTONS #4521');

        expect(match, isNotNull);
        expect(match!.categoryId, 1);
      },
    );

    test('findMatchFor returns null when nothing matches', () async {
      await repository.insert(
        MerchantRule(pattern: 'TIM HORTONS', categoryId: 1),
      );

      final match = await repository.findMatchFor('SHELL GAS STATION');

      expect(match, isNull);
    });

    test('findMatchFor is case-insensitive', () async {
      await repository.insert(
        MerchantRule(pattern: 'tim hortons', categoryId: 1),
      );

      final match = await repository.findMatchFor('TIM HORTONS #4521');

      expect(match, isNotNull);
    });
  });
}
