import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todolist/stores/item_store/item_store.dart';

class ItemWidget extends StatelessWidget {
  final ItemStore item;

  const ItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        title: Text(
          item.name,
          style:
              TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${item.date}",
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: IconButton(
          icon: Icon(
              item.check ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.clock_solid),
          color: item.check ? Colors.greenAccent : Colors.redAccent,
          onPressed: () => item.setCheck(!item.check),
        ),
        //isThreeLine: true,
      );
    });
  }
}
