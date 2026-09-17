import 'package:flutter_test/flutter_test.dart';
import 'package:build_on_finance/data/database_helper.dart';
import 'package:build_on_finance/data/repositories/accounts/account_repository.dart';
import 'package:build_on_finance/models/accounts/account.dart';

import '../../../helpers/test_db_helper.dart';

void main() {
  late DatabaseHelper dbHelper;
  late AccountRepository repository;

  setUpAll(() {
    dbHelper = initTestDb();
    repository = AccountRepository(dbHelper: dbHelper);
  });

  Account createAccount(String name, String type, String last4) {
    return Account(name: name, type: type, last4: last4);
  }

  Account createChequingAccount() {
    return createAccount('Chequing', 'checking', '1234');
  }

  Account createSavingsAccount() {
    return createAccount('Savings', 'savings', '5678');
  }

  setUp(() async {
    await resetTestDb(dbHelper);
  });

  tearDownAll(() async {
    await dbHelper.close();
  });

  group('AccountRepository', () {
    test('insert then getById returns the same account', () async {
      final account = createChequingAccount();
      final id = await repository.insert(account);

      final fetched = await repository.getById(id);

      expect(fetched, isNotNull);
      expect(fetched!.name, 'Chequing');
      expect(fetched.last4, '1234');
      expect(fetched.type, 'checking');
    });

    test('getById returns null for a non-existent id', () async {
      final fetched = await repository.getById(9999);
      expect(fetched, isNull);
    });

    test('getAll returns every inserted account', () async {
      await repository.insert(createChequingAccount());
      await repository.insert(createSavingsAccount());

      final all = await repository.getAll();

      expect(all.length, 2);
      expect(all.map((a) => a.name), containsAll(['Chequing', 'Savings']));
    });

    test('update modifies an existing account', () async {
      final id = await repository.insert(createChequingAccount());
      final original = await repository.getById(id);

      final updated = original!.copyWith(name: 'Chequing (renamed)');
      await repository.update(updated);

      final fetched = await repository.getById(id);
      expect(fetched!.name, 'Chequing (renamed)');
    });

    test('delete removes the account', () async {
      final id = await repository.insert(createChequingAccount());
      await repository.delete(id);

      final fetched = await repository.getById(id);
      expect(fetched, isNull);
    });
  });
}
