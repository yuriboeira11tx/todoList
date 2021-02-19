import 'package:mobx/mobx.dart';
part 'item_store.g.dart';

class ItemStore = _ItemStoreBase with _$ItemStore;

abstract class _ItemStoreBase with Store {
  _ItemStoreBase({this.name, this.check = false});

  @observable
  String name;

  @observable
  bool check = false;

  @action
  void setName(String value) => name = value;

  @action
  void setCheck(bool value) => check = value;

  @computed
  bool get isCheck => check;
}
