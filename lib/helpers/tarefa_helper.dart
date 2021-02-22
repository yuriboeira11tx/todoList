import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tarefaTable = "tarefaTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String checkColumn = "checkColumn";

class TarefaHelper {
  // criar apenas uma instância da classe
  static final TarefaHelper _instance = TarefaHelper.internal();
  factory TarefaHelper() => _instance;
  TarefaHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "tarefas.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $tarefaTable($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $checkColumn INTEGER)");
    });
  }

  Future<Tarefa> saveTarefa(Tarefa tarefa) async {
    Database dbTarefa = await db;
    tarefa.id = await dbTarefa.insert(tarefaTable, tarefa.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return tarefa;
  }

  Future<Tarefa> getTarefa(int id) async {
    Database dbTarefa = await db;
    List<Map> maps = await dbTarefa.query(tarefaTable,
        columns: [idColumn, nameColumn, checkColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Tarefa.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteTarefa(int id) async {
    Database dbTarefa = await db;
    return await dbTarefa
        .delete(tarefaTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateTarefa(Tarefa tarefa) async {
    Database dbTarefa = await db;
    return await dbTarefa.update(tarefaTable, tarefa.toMap(),
        where: "$idColumn = ?", whereArgs: [tarefa.id]);
  }

  Future<List> getAll() async {
    Database dbTarefa = await db;
    List listMap = await dbTarefa.query(tarefaTable);
    List<Tarefa> listTarefa = List();

    for (Map m in listMap) {
      listTarefa.add(Tarefa.fromMap(m));
    }

    return listTarefa;
  }

  Future close() async {
    Database dbTarefa = await db;
    dbTarefa.close();
  }
}

class Tarefa {
  int id;
  String name;
  int check;

  Tarefa();

  Tarefa.fromMap(Map map) {
    this.id = map[idColumn];
    this.name = map[nameColumn];
    this.check = map[checkColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      checkColumn: check,
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Tarefa(id: $id, name: $name, check: $check)";
  }
}
