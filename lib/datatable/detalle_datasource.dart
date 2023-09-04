import 'package:flutter_application_4/model/cc0752.dart';
import 'package:flutter_application_4/provider/ingreso_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class DetalleDTS extends DataGridSource {
  DetalleDTS(this.provider, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final IngresoProvider provider;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = provider.listDetail.map<DataGridRow>((Cc0752 team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'codigo', value: team.ctaRut),
        DataGridCell<String>(
            columnName: 'nombre',
            value: provider.listCliente
                .where((element) => element.codRef == team.ctaRut)
                .toList()
                .first
                .nomRef),
        DataGridCell<String>(columnName: 'tipo', value: team.speRut),
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
          child: Text(row.getCells()[0].value.toString(),
              textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
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
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Tooltip(
          message: 'Eliminar registro',
          child: InkWell(
            onTap: () {
              provider.isDelete(row.getCells()[0].value.toString());
            },
            child: const Icon(
              Icons.delete_sharp,
              color: Colors.red,
            ),
          ),
        ),
      ),
    ]);
  }
}
