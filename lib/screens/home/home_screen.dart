import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todolist/screens/home/widgets/item_widget.dart';
import 'package:todolist/stores/home_store/home_store.dart';
import 'package:todolist/stores/item_store/item_store.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = HomeStore();

  @override
  Widget build(BuildContext context) {
    _dialog() {
      var itemModel = ItemStore();

      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Adicionar Tarefa"),
              content: TextField(
                onChanged: itemModel.setName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome da Nova Tarefa",
                ),
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.deepPurple,
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () {
                    itemModel.setDate(DateFormat("dd/MM").format(DateTime.now()));
                    homeStore.addItem(itemModel);
                    Navigator.pop(context);
                  },
                  child: Text("Adicionar"),
                ),
              ],
            );
          });
    }

    _dialogUpdate(ItemStore itemStore) {
      var itemModel = itemStore;

      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("Atualizar Tarefa"),
              content: TextField(
                onChanged: itemModel.setName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Novo Nome da Tarefa",
                ),
                textCapitalization: TextCapitalization.words,
                cursorColor: Colors.deepPurple,
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () {
                    itemModel.setDate(DateFormat("dd/MM").format(DateTime.now()));
                    homeStore.updateItem(itemModel);
                    Navigator.pop(context);
                  },
                  child: Text("Atualizar"),
                ),
              ],
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.deepPurple[600],
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              child: Image.asset(
                'assets/image.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Text(
                "ToDo List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              top: 40,
              left: 20,
            ),
            Positioned(
              child: Text(
                "Adicione, remova e conclua suas tarefas!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              top: 100,
              left: 20,
            ),
            Observer(builder: (_) {
              return Positioned(
                child: Text(
                  "${homeStore.listItems.length}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                top: 55,
                right: 20,
              );
            }),
            DraggableScrollableSheet(
              maxChildSize: 0.85,
              minChildSize: 0.1,
              builder: (context, scrolController) {
                return Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                        ),
                        child: Observer(
                          builder: (_) {
                            return ListView.builder(
                              controller: scrolController,
                              itemCount: homeStore.listItems.length,
                              itemBuilder: (context, index) {
                                var item = homeStore.listItems[index];

                                return GestureDetector(
                                  child: Dismissible(
                                    key: ValueKey(item),
                                    child: ItemWidget(
                                      item: item,
                                    ),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed: (direction) {
                                      homeStore.removeItem(item);
                                    }),
                                  onTap: () => _dialogUpdate(item),
                                );
                              },
                            );
                          },
                        )),
                    Positioned(
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.pinkAccent,
                        onPressed: () => _dialog(),
                      ),
                      top: -30,
                      right: 30,
                    )
                  ],
                );
              },
            )
          ],
        ));
  }
}
