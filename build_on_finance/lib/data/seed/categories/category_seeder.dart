import '../../../models/categories/category.dart';
import '../../repositories/categories/category_repository.dart';
import 'default_categories.dart';

class CategorySeeder {
  CategorySeeder({CategoryRepository? categoryRepository})
    : _categoryRepository = categoryRepository ?? CategoryRepository();

  final CategoryRepository _categoryRepository;

  Future<void> seed() async {
    final existing = await _categoryRepository.getAll();

    final topLevelByName = <String, Category>{
      for (final c in existing.where((c) => c.parentId == null)) c.name: c,
    };

    final childNamesByParentId = <int, Set<String>>{};
    for (final c in existing.where((c) => c.parentId != null)) {
      childNamesByParentId.putIfAbsent(c.parentId!, () => {}).add(c.name);
    }

    for (final entry in defaultCategories.entries) {
      final parentName = entry.key;
      final childNames = entry.value;

      final existingParent = topLevelByName[parentName];
      final int parentId = existingParent != null
          ? existingParent.id!
          : await _categoryRepository.insert(
              Category(name: parentName, parentId: null, budgetMonthly: null),
            );

      final existingChildNames = childNamesByParentId.putIfAbsent(
        parentId,
        () => {},
      );

      for (final childName in childNames) {
        if (existingChildNames.contains(childName)) continue;

        await _categoryRepository.insert(
          Category(name: childName, parentId: parentId, budgetMonthly: null),
        );
        existingChildNames.add(childName);
      }
    }
  }
}
