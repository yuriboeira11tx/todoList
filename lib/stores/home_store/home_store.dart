import 'package:mobx/mobx.dart';
import 'package:todolist/stores/item_store/item_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<ItemStore> listItems = ObservableList<ItemStore>();

  _HomeStoreBase() {
    listItems.add(ItemStore(name: "Revisar suprimentos na geladeira", check: true));
    listItems.add(ItemStore(name: "Assistir Harry Potter", check: true));
    listItems.add(ItemStore(name: "Fazer fricassê de frango no jantar", check: false));
  }

  @action
  void addItem(ItemStore item) => listItems.add(item);

  @action
  void removeItem(ItemStore item) => listItems.remove(item);
}
