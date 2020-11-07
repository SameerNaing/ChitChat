import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:chit_chat/models/models.dart';

class HiveDbOperations {
  Box box;
  Future<void> hiveRegisterAdapter() {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(AccountsAdapter());
  }

  Future<void> hiveOpenBox({@required boxName}) async {
    bool open = Hive.isBoxOpen(boxName);
    if (open) {
      box = Hive.box(boxName);
    } else {
      box = await Hive.openBox(boxName);
    }
  }

  Future<void> addAccount(Accounts account) async {
    await box.add(account);
  }

  Future<void> deleteAccount(int index) async {
    await box.deleteAt(index);
  }

  Future<Accounts> getAccount(int index) async {
    return await box.getAt(index);
  }

  Future<List<Accounts>> getAllAccounts() async {
    List<Accounts> acc = new List();
    for (var i = 0; i < box.length; i++) acc.add(box.getAt(i) as Accounts);
    return acc;
  }

  Future<void> closeBox() async {
    return await box.close();
  }

  Future<bool> accountExists(String uid) async {
    List<Accounts> acc = await getAllAccounts();
    List<String> ids = List.from(acc.map((value) => value.uid));
    return ids.contains(uid);
  }

  Future<int> getIndex(String uid) async {
    List<Accounts> acc = await getAllAccounts();
    List<String> ids = List.from(acc.map((value) => value.uid));
    return ids.indexOf(uid);
  }
}
