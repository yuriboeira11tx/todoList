import 'package:mobx/mobx.dart';
import 'package:todolist/helpers/tarefa_helper.dart';
import 'package:todolist/stores/item_store/item_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<ItemStore> listItems = ObservableList<ItemStore>();
  TarefaHelper tarefaHelper = TarefaHelper();

  _HomeStoreBase() {
    loadItems();
  }

  @action
  void addItem(ItemStore item) {
    Tarefa tarefaNova = Tarefa();
    tarefaNova.id = item.id;
    tarefaNova.name = item.name;
    tarefaNova.date = item.date;
    tarefaNova.check = 0;

    if (tarefaNova.name == null || tarefaNova.name.isEmpty) tarefaNova.name = "Sem nome";

    tarefaHelper.saveTarefa(tarefaNova);

    loadItems();
  }

  @action
  void removeItem(ItemStore item) {
    tarefaHelper.deleteTarefa(item.id);

    listItems.remove(item);
  }

  @action
  void updateItem(ItemStore item) {
    Tarefa tarefa = Tarefa();
    tarefa.id = item.id;
    tarefa.name = item.name;
    tarefa.date = item.date;
    tarefa.check = item.check ? 1 : 0;

    tarefaHelper.updateTarefa(tarefa);
  }

  @action
  void loadItems() {
    listItems.clear();

    tarefaHelper.getAll().then((listaTarefas) {
      for (Tarefa tarefa in listaTarefas) {
        listItems.add(ItemStore(
            id: tarefa.id,
            name: tarefa.name,
            date: tarefa.date,
            check: tarefa.check == 1 ? true : false));
      }
    });
  }
}
