import 'package:flutter_application_4/model/cliente.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class ClienteDTS extends DataGridSource {
  ClienteDTS(this.list, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final List<ClienteVen> list;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = list.map<DataGridRow>((ClienteVen team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: team.cliente),
        DataGridCell<String>(columnName: 'nombre', value: team.ncliente),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(
            row.getCells()[0].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(
            row.getCells()[1].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
    ]);
  }
}
