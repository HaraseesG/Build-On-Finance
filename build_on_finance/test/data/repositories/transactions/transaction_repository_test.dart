import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/transactions/transaction_repository.dart';
import 'package:build_on_finance/models/transactions/transaction.dart';
import 'package:build_on_finance/models/transactions/enums/transaction_direction.dart';
import 'package:build_on_finance/models/transactions/enums/transaction_source.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late TransactionRepository repository;

  setUpAll(() {
    dbHelper = initTestDb();
    repository = TransactionRepository(dbHelper: dbHelper);
  });

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  group('TransactionRepository', () {
    Transaction sampleTransaction({int accountId = 1}) {
      return Transaction(
        accountId: accountId,
        amount: 42.50,
        direction: TransactionDirection.debit,
        merchantRaw: 'TIM HORTONS #4521',
        date: DateTime(2026, 9, 1),
        source: TransactionSource.manual,
      );
    }

    test('insert then getById returns the same transaction', () async {
      final id = await repository.insert(sampleTransaction());
      final fetched = await repository.getById(id);

      expect(fetched, isNotNull);
      expect(fetched!.amount, 42.50);
      expect(fetched.direction, TransactionDirection.debit);
      expect(fetched.source, TransactionSource.manual);
    });

    test('getById returns null for a non-existent id', () async {
      final fetched = await repository.getById(9999);
      expect(fetched, isNull);
    });

    test('getAll returns transactions ordered by date descending', () async {
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 1, 1)),
      );
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 6, 1)),
      );

      final all = await repository.getAll();

      expect(all.length, 2);
      expect(all.first.date, DateTime(2026, 6, 1));
    });

    test('getAll returns transactions ordered by date descending', () async {
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 1, 1)),
      );
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 6, 1)),
      );

      final all = await repository.getAll();

      expect(all.length, 2);
      expect(all.first.date, DateTime(2026, 6, 1));
    });

    test('getAll returns transactions ordered by date descending', () async {
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 1, 1)),
      );
      await repository.insert(
        sampleTransaction().copyWith(date: DateTime(2026, 6, 1)),
      );

      final all = await repository.getAll();

      expect(all.length, 2);
      expect(all.first.date, DateTime(2026, 6, 1));
    });

    test('getByAccountId only returns transactions for that account', () async {
      await repository.insert(sampleTransaction(accountId: 1));
      await repository.insert(sampleTransaction(accountId: 2));

      final forAccount1 = await repository.getByAccountId(1);

      expect(forAccount1.length, 1);
      expect(forAccount1.first.accountId, 1);
    });

    test(
      'inserting an invalid direction is rejected by CHECK constraint',
      () async {
        final db = await DatabaseHelper.forTesting().database;
        expect(
          () => db.insert('transactions', {
            'account_id': 1,
            'amount': 10.0,
            'direction': 'sideways',
            'date': DateTime.now().toIso8601String(),
            'source': 'manual',
          }),
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
