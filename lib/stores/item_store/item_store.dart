import 'package:mobx/mobx.dart';
import 'package:todolist/helpers/tarefa_helper.dart';
part 'item_store.g.dart';

class ItemStore = _ItemStoreBase with _$ItemStore;

abstract class _ItemStoreBase with Store {
  TarefaHelper tarefaHelper = TarefaHelper();

  _ItemStoreBase({this.id, this.name, this.check = false});

  @observable
  int id;

  @observable
  String name;

  @observable
  bool check = false;

  @action
  void setId(int value) => id = value;

  @action
  void setName(String value) => name = value;

  @action
  void setCheck(bool value) {
    check = value;

    Tarefa tarefa = Tarefa();
    tarefa.id = id;
    tarefa.name = name;
    tarefa.check = check ? 1 : 0;

    tarefaHelper.updateTarefa(tarefa);
  }

  @computed
  bool get isCheck => check;
}
