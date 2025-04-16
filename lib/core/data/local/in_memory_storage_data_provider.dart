import 'package:flutter_riverpod/flutter_riverpod.dart';

final inMemoryStorageProvider = Provider<InMemoryStorageDataProvider>((ref) => InMemoryStorageDataProvider());

class InMemoryStorageDataProvider {
  final Map<String, dynamic> _memoryMap = <String, dynamic>{};

  bool containsKey({required String key}) {
    return _memoryMap.containsKey(key);
  }

  void delete({required String key}) {
    _memoryMap.remove(key);
  }

  void deleteAll() {
    _memoryMap.clear();
  }

  T? get<T>({required String key}) {
    return _memoryMap[key] as T?;
  }

  void put<T>({required String key, required T value}) {
    _memoryMap[key] = value;
  }
}
