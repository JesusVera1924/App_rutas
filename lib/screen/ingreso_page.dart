// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/datatable/detalle_datasource.dart';
import 'package:flutter_application_4/model/mg0032.dart';
import 'package:flutter_application_4/provider/ingreso_provider.dart';
import 'package:flutter_application_4/provider/login_provider.dart';
import 'package:flutter_application_4/style/custom_inputs.dart';
import 'package:flutter_application_4/util/date_formatter.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:flutter_application_4/widget/custom_icon_button.dart';
import 'package:flutter_application_4/util/dialog_aceptar.dart';
import 'package:flutter_application_4/widget/white_card.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:filter_list/filter_list.dart';

class IngresoPage extends StatefulWidget {
  const IngresoPage({Key? key}) : super(key: key);

  @override
  State<IngresoPage> createState() => _IngresoPageState();
}

class _IngresoPageState extends State<IngresoPage> {
  @override
  void initState() {
    Provider.of<IngresoProvider>(context, listen: false).initial();
    Provider.of<LoginProvider>(context, listen: false).getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IngresoProvider>(context);
    final providerLogin = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;

    Future openFilterDelegate() async {
      await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
          provider.getClientxVendedor(providerLogin.codigo),
          message: const Text('Cargando...'),
        ),
      );
      await FilterListDelegate.show<Mg0032>(
        context: context,
        list: provider.listCliente,
        selectedListData: provider.listClienteSelect,
        applyButtonText: "Guardar",
        theme: FilterListDelegateThemeData(
          listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              tileColor: Colors.white,
              selectedColor: Colors.red,
              selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
              textColor: Colors.blue),
        ),
        onItemSearch: (user, query) {
          return user.nomRef.toLowerCase().contains(query.toLowerCase()) ||
              user.codRef.toLowerCase().contains(query.toLowerCase());
        },
        enableOnlySingleSelection: false,
        tileLabel: (user) => user!.nomRef,
        emptySearchChild: const Center(child: Text('Sin clientes')),
        searchFieldHint: 'Busqueda por nombre y codigo..',
        onApplyButtonClick: (list) async {
          setState(() {
            provider.listClienteSelect = list!;
            provider.addDetail(providerLogin.codigo);
          });
        },
      );
    }

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        setState(() {
          switch (cadena) {
            case 'init':
              provider.txtFecha.text =
                  UtilView.dateFormatDMY(picked.toString());
              /* final now = DateTime.now();
              final rep = !now.isAfter(picked);
              if (rep) {
                provider.txtFecha.text =
                    UtilView.dateFormatDMY(picked.toString());
              } else {} */
              break;

            default:
          }
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan de rutas'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      //drawer: const MenuLateral(),
      body: ListView(
        children: [
          WhiteCard(
            title: '  ',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Vendedor: ${providerLogin.codigo}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(providerLogin.nombre.trim(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: provider.txtNumero,
                      enabled: false,
                      decoration: size.width < 500
                          ? CustomInputs.boxInputDecoration3(
                              hint: 'Numero de ruta',
                              icon: Icons.confirmation_num)
                          : CustomInputs.boxInputDecoration2(
                              hint: 'Numero de ruta',
                              icon: Icons.confirmation_num),
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: provider.txtFecha,
                          decoration: CustomInputs.boxInputDecorationDatePicker(
                              labelText: 'Fecha de ruta',
                              fc: () => selectDate('init')),
                          inputFormatters: [DateFormatter()],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: provider.txtValorr,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: size.width < 500
                            ? CustomInputs.boxInputDecoration3(
                                hint: 'Posible Valor de recaudacion',
                                icon: Icons.monetization_on_outlined)
                            : CustomInputs.boxInputDecoration2(
                                hint: 'Posible Valor de recaudacion',
                                icon: Icons.monetization_on_outlined),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: provider.txtValorv,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                          LengthLimitingTextInputFormatter(8),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: size.width < 500
                            ? CustomInputs.boxInputDecoration3(
                                hint: 'Posible valor de venta',
                                icon: Icons.monetization_on_outlined)
                            : CustomInputs.boxInputDecoration2(
                                hint: 'Posible valor de venta',
                                icon: Icons.monetization_on_outlined),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: provider.txtObservacion,
                          decoration: CustomInputs.boxInputDecoration2(
                              hint: 'Observación', icon: Icons.assignment),
                          maxLines: 4,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),
                          ],
                        )),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                        onPressed: () async {
                          final resp =
                              await provider.isCheckSave(providerLogin.codigo);
                          if (resp) {
                            await openFilterDelegate();
                          }
                        },
                        color: Colors.blueGrey,
                        text: 'Agregar clientes',
                        icon: Icons.save)
                  ],
                )
              ],
            ),
          ),
          WhiteCard(
              title: 'Detalle',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SfDataGrid(
                    source: DetalleDTS(provider, context),
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    headerRowHeight: 40.0,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: 'codigo',
                          width: 70,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Codigo',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'nombre',
                          columnWidthMode: ColumnWidthMode.fill,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Nombre',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'tipo',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('T',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                      GridColumn(
                          columnName: 'acciones',
                          columnWidthMode: ColumnWidthMode.fitByColumnName,
                          label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text('Borrar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          )),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconButton(
                          onPressed: () async {
                            if (provider.listDetail.isNotEmpty) {
                              final opt = await dialogAcepCanc(
                                  context,
                                  'Advertencia',
                                  'Deseas finalizar?',
                                  Icons.warning,
                                  Colors.red);
                              if (opt) {
                                provider.saveRuta(providerLogin.codigo);
                                Navigator.pushNamed(context, 'homePage');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Transaccion cancelada')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Lista de ruta vacia')),
                              );
                            }
                          },
                          color: Colors.blueGrey,
                          //    focus: myFocusNode,
                          text: 'Cierre de rutero',
                          icon: Icons.save)
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}


     /* final dataGridController = DataGridController();
                          await provider
                              .getClientxVendedor(providerLogin.codigo);

                          if (provider.listAux.isNotEmpty) {
                            provider.listClienteTemp = await dialogMultiple(
                                context,
                                'Lista de clientes'.toUpperCase(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SfDataGrid(
                                          source: ClienteDTS(
                                              provider.listAux, context),
                                          headerRowHeight: 30.0,
                                          rowHeight: 30.0,
                                          controller: dataGridController,
                                          showCheckboxColumn: true,
                                          selectionMode: SelectionMode.multiple,
                                          columns: [
                                            GridColumn(
                                                columnName: 'codigo',
                                                columnWidthMode: ColumnWidthMode
                                                    .fitByColumnName,
                                                label: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Codigo',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                            GridColumn(
                                                columnName: 'nombre',
                                                columnWidthMode:
                                                    ColumnWidthMode.fill,
                                                label: Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Cliente',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )),
                                          ]),
                                    ],
                                  ),
                                ),
                                Icons.schedule_sharp,
                                Colors.red,
                                dataGridController,
                                provider);

                            if (provider.listClienteTemp.isNotEmpty) {
                              provider.txtCliente.text =
                                  provider.listClienteTemp.toString();
                            } else {
                              provider.txtCliente.clear();
                            }
                          }
                          provider.optTest();
                          provider.addDetail(providerLogin.codigo); */
                     