import 'dart:async';

import 'package:flutter_application_4/model/cc0751.dart';
import 'package:flutter_application_4/model/cc0752.dart';
import 'package:flutter_application_4/model/cc0753.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConexionDb {
  static final ConexionDb instance = ConexionDb._int();

  static Database? _database;

  ConexionDb._int();

  final String tableCc0751 = "cc0751";
  final String tableCc0752 = "cc0752";
  final String tableCc0753 = "cc0753";

  FutureOr<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('respaldo.db');
    return _database;
  }

  FutureOr<Database> _initDB(String filepath) async {
    /* final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath); */
    final dbpath = await getExternalStorageDirectory();
    final path = join(dbpath!.path, filepath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  FutureOr<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableCc0751 ( 
	  cod_emp	VARCHAR(2) NOT NULL,
	  rvc_ruc	VARCHAR(4) NOT NULL,
	  num_rut	VARCHAR(9) NOT NULL,
	  fec_rut	DATETIME,
	  obs_rut	VARCHAR(50),
	  ndc_rut	SMALLINT,
	  vta_rut	DECIMAL(12,2),
	  rec_rut	DECIMAL(12,2),
	  sts_rut	VARCHAR(1) 
	  );
''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableCc0752(
      cod_emp	VARCHAR(2) NOT NULL,
	    rvc_ruc	VARCHAR(4) NOT NULL,
	    num_rut	VARCHAR(9) NOT NULL,
	    cta_rut	VARCHAR(4) NOT NULL,
	    fcr_rut	DATETIME,
	    spe_rut	VARCHAR(1) NOT NULL,
	    sts_rut	VARCHAR(1) NOT NULL	
    );
''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableCc0753(
      cod_emp	VARCHAR(2) NOT NULL,
	    rvc_act	VARCHAR(4) NOT NULL,
	    fec_act	DATE,
	    hra_act	VARCHAR(8) NOT NULL,
	    obs_act	VARCHAR(100) NOT NULL,
	    fyt_act	DATETIME,
	    srs_act	VARCHAR(1) NOT NULL,	
	    sts_act	VARCHAR(1) NOT NULL	
    );
''');
  }

  FutureOr<void> insert(Cc0751 model) async {
    final db = await instance.database;
    await db!.insert(tableCc0751, model.toMap());
  }

  FutureOr<void> insert2(Cc0752 model) async {
    final db = await instance.database;
    await db!.insert(tableCc0752, model.toMap());
  }

  FutureOr<void> insert3(Cc0753 model) async {
    final db = await instance.database;
    await db!.insert(tableCc0753, model.toMap());
  }

  Future<List<Cc0751>> getAllRegistros() async {
    final db = await instance.database;
    //A --> ACTIVO   E --> CORREO YA FUE ENVIADO POR PRIMERA VEZ Y SIGUE ACTIVO I--> INACTIVO
    final List<Map<String, dynamic>> maps =
        await db!.query(tableCc0751, where: "sts_rut in ('A','E') ");

    return List.generate(maps.length, (i) {
      return Cc0751(
          codEmp: maps[i]['cod_emp'],
          rvcRuc: maps[i]['rvc_ruc'],
          numRut: maps[i]['num_rut'],
          fecRut: UtilView.convertStringToDate2(maps[i]['fec_rut']),
          obsRut: maps[i]['obs_rut'],
          ndcRut: "${maps[i]['ndc_rut']}",
          vtaRut: maps[i]['vta_rut'].toDouble(),
          recRut: maps[i]['rec_rut'].toDouble(),
          stsRut: maps[i]['sts_rut']);
    });
  }

  Future<List<Cc0752>> getAllRegistros2(String uid) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableCc0752, where: "num_rut = '$uid'");

    return List.generate(maps.length, (i) {
      return Cc0752(
          codEmp: maps[i]['cod_emp'],
          rvcRuc: maps[i]['rvc_ruc'],
          numRut: maps[i]['num_rut'],
          ctaRut: maps[i]['cta_rut'],
          fcrRut: UtilView.convertStringToDate2(maps[i]['fcr_rut']),
          speRut: maps[i]['spe_rut'],
          stsRut: maps[i]['sts_rut']);
    });
  }

  Future<List<Cc0753>> getAllRegistros3(String uid) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db!.query(tableCc0753, where: "rvc_act = '$uid'");

    return List.generate(maps.length, (i) {
      return Cc0753(
          codEmp: maps[i]['cod_emp'],
          rvcAct: maps[i]['rvc_act'],
          fecAct: UtilView.convertStringToDate2(maps[i]['fec_act']),
          hraAct: maps[i]['hra_act'],
          obsAct: maps[i]['obs_act'],
          fytAct: UtilView.convertStringToDate2(maps[i]['fyt_act']),
          srsAct: maps[i]['srs_act'],
          stsAct: maps[i]['sts_act']);
    });
  }

  Future<int> updateRegistros(String uid) async {
    final db = await instance.database;
    int count = await db!.rawUpdate(
        'UPDATE $tableCc0751 SET sts_rut = ? WHERE num_rut = ? and sts_rut in (?, ?)',
        ['I', uid, "A", "E"]);

    return count;
  }

  Future<int> updateRegistroEmail(String uid) async {
    final db = await instance.database;
    int count = await db!.rawUpdate(
        'UPDATE $tableCc0751 SET sts_rut = ? WHERE num_rut = ? and sts_rut = ?',
        ['E', uid, "A"]);

    return count;
  }

  Future<int> updateRegistrosCc0753(
      String uid, DateTime fecha, String hora) async {
    final db = await instance.database;
    int count = await db!.rawUpdate(
        'UPDATE $tableCc0753 SET sts_act = ? WHERE rvc_act = ? and hra_act = ?',
        ['*', uid, hora]);

    return count;
  }
}
