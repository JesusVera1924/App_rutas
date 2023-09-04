// ignore_for_file: use_build_context_synchronously

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/model/cc0752M.dart';
import 'package:flutter_application_4/model/mg0032.dart';
import 'package:flutter_application_4/provider/check_provider.dart';
import 'package:flutter_application_4/provider/login_provider.dart';
import 'package:flutter_application_4/style/custom_inputs.dart';
import 'package:flutter_application_4/util/date_formatter.dart';
import 'package:flutter_application_4/util/dialog.dart';
import 'package:flutter_application_4/util/dialog_check.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:flutter_application_4/widget/custom_icon_button.dart';
import 'package:flutter_application_4/widget/white_card.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  void initState() {
    Provider.of<LoginProvider>(context, listen: false).getValues();
    Provider.of<CheckProvider>(context, listen: false).clearObjeto2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerLogin = Provider.of<LoginProvider>(context);
    final provider = Provider.of<CheckProvider>(context);
    final size = MediaQuery.of(context).size;

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022), //menor
        lastDate: DateTime(2023), //mayor
        // lastDate: DateTime(2022, DateTime.now().month, DateTime.now().day - 7),
      );
      if (picked != null) {
        setState(() {
          switch (cadena) {
            case 'init':
              provider.txtFec.text = UtilView.dateFormatDMY(picked.toString());
              break;
            case 'init2':
              provider.txtSgt.text = UtilView.dateFormatDMY(picked.toString());
              break;

            default:
          }
        });
      }
    }

    Future openFilterDelegate() async {
      await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(
            provider.getClientxVendedor(providerLogin.codigo),
            message: const Text('Cargando...')),
      );
      await FilterListDelegate.show<Mg0032>(
        context: context,
        list: provider.listCliente,
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
          return user.codRef.toLowerCase().contains(query.toLowerCase()) ||
              user.nomRef.toLowerCase().contains(query.toLowerCase());
        },
        tileLabel: (user) => user!.nomRef,
        emptySearchChild: const Center(child: Text('Ciente no encontrado')),
        enableOnlySingleSelection: true,
        searchFieldHint: 'Busqueda por nombre y codigo..',
        onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {
              provider.txtNum.text = "";
              provider.isCliente = list.first;
              provider.txtCta.text =
                  "${list.first.codRef}-${list.first.nomRef}";
            });
          }
        },
      );
    }

    Future openFilterDelegate2() async {
      await FilterListDelegate.show<Cc0752M>(
        context: context,
        list: provider.listClienteModel,
        theme: FilterListDelegateThemeData(
          listTileTheme: ListTileThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.white,
            selectedColor: Colors.red,
            selectedTileColor: const Color(0xFF649BEC).withOpacity(.5),
            textColor: Colors.blue,
          ),
        ),
        onItemSearch: (user, query) {
          return user.ctaRut.toLowerCase().contains(query.toLowerCase()) ||
              user.nomRef.toLowerCase().contains(query.toLowerCase());
        },
        tileLabel: (user) =>
            "[${user!.ctaRut}] - ${user.nomRef} ${user.stsRut == "P" ? " * " : ""}",
        emptySearchChild: const Center(child: Text('Ciente no encontrado')),
        enableOnlySingleSelection: true,
        searchFieldHint: 'Busqueda por nombre y codigo..',
        onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {
              provider.isClienteModel = list.first;
              provider.txtCta.text =
                  "${list.first.ctaRut}-${list.first.nomRef}";
            });
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de visitas [Rutas]'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Lista de rutas', style: TextStyle(fontSize: 14)),
                ),
              ];
            },
            onSelected: (value) async {
              if (value == 0) {
                var xp = await provider.getListRutas(providerLogin.codigo);
                if (xp.isNotEmpty) {
                  await dialog(
                      context,
                      'Lista de rutas',
                      SizedBox(
                        width: 2.0 * 56.0,
                        height: 200,
                        child: ListView.builder(
                          itemCount: xp.length,
                          itemBuilder: (context, i) {
                            return Card(
                              child: ListTile(
                                title: Text(xp[i].numRut),
                                subtitle: Text(DateFormat("dd/MM/yy")
                                    .format(xp[i].fecRut)
                                    .toString()),
                                trailing: const Icon(Icons.star),
                                onTap: () {
                                  provider.txtFec.text =
                                      DateFormat("dd/MM/yyyy")
                                          .format(xp[i].fecRut)
                                          .toString();
                                  provider.txtNum.text = xp[i].numRut;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Icons.assignment,
                      Colors.lightBlueAccent,
                      presente: false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sin registros....')),
                  );
                }
              }
            },
          )
        ],
      ),
      body: ListView(
        children: [
          WhiteCard(
              title: ' ',
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
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: provider.txtFec,
                            style:
                                TextStyle(fontSize: size.width < 420 ? 14 : 16),
                            decoration:
                                CustomInputs.boxInputDecorationDatePicker(
                                    labelText: 'Fecha de ruta',
                                    fc: () => selectDate('init')),
                            inputFormatters: [DateFormatter()],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: TextFormField(
                        controller: provider.txtNum,
                        enabled: false,
                        style: TextStyle(fontSize: size.width < 420 ? 14 : 16),
                        decoration: size.width < 400
                            ? CustomInputs.boxInputDecoration3(
                                hint: 'Numero de ruta',
                                icon: Icons.confirmation_num)
                            : CustomInputs.boxInputDecoration2(
                                hint: 'Numero de ruta',
                                icon: Icons.confirmation_num),
                      )),
                      const SizedBox(width: 8),
                      MaterialButton(
                        minWidth: 10,
                        //height: 45,
                        color: Colors.grey,
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                                provider.getListModel(providerLogin.codigo),
                                message: const Text('Cargando...')),
                          );
                          if (provider.isBusqueda) {
                            openFilterDelegate2();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sin registro')),
                            );
                          }
                        },
                        child: const Icon(Icons.search),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 2, top: 5),
                        child: TextFormField(
                          controller: provider.txtCta,
                          readOnly: true,
                          validator: (value) {
                            if (provider.txtCta.text.isEmpty) {
                              return "Requerido";
                            }
                            return null;
                          },
                          onTap: () async => openFilterDelegate(),
                          decoration: CustomInputs.boxInputDecoration2(
                              hint: 'Cliente', icon: Icons.person),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  size.width < 450
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tipo visita',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 5),
                            CustomCheckBoxGroup(
                              width: 123,
                              elevation: 0,
                              absoluteZeroSpacing: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: UtilView.tipoVisita,
                              buttonValuesList: UtilView.tipoVisita,
                              buttonTextStyle: const ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16)),
                              checkBoxButtonValues: (value) {
                                provider.txtTvc.clear();
                                for (var element in value) {
                                  provider.txtTvc.text +=
                                      (element as String).substring(0, 1);
                                }
                              },
                              selectedColor: Theme.of(context).primaryColor,
                            ),
                            /*    const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: TextFormField(
                                controller: provider.txtSgt,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker2(
                                        labelText: 'Siguiente visita',
                                        fc: () => selectDate('init')),
                                inputFormatters: [DateFormatter()],
                              ),
                            ), */
                          ],
                        )
                      : Row(
                          children: [
                            const Text('Tipo\nvisita',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              width: 30,
                            ),
                            CustomCheckBoxGroup(
                              width: 115,
                              elevation: 0,
                              absoluteZeroSpacing: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: UtilView.tipoVisita,
                              buttonValuesList: UtilView.tipoVisita,
                              buttonTextStyle: const ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(fontSize: 16)),
                              checkBoxButtonValues: (value) {
                                provider.txtTvc.clear();
                                for (var element in value) {
                                  provider.txtTvc.text +=
                                      (element as String).substring(0, 1);
                                }
                              },
                              selectedColor: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  controller: provider.txtSgt,
                                  decoration: CustomInputs
                                      .boxInputDecorationDatePicker2(
                                          labelText: 'Siguiente visita',
                                          fc: () => selectDate('init')),
                                  inputFormatters: [DateFormatter()],
                                ),
                              ),
                            ),
                          ],
                        ),
                  /*  const SizedBox(height: 10),
                  size.width < 500
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Accion realizada',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomRadioButton(
                                    elevation: 0,
                                    absoluteZeroSpacing: true,
                                    width: 123,
                                    unSelectedColor:
                                        Theme.of(context).canvasColor,
                                    buttonLables: UtilView.entrega,
                                    buttonValues: UtilView.entrega,
                                    buttonTextStyle: const ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Colors.black,
                                        textStyle: TextStyle(fontSize: 16)),
                                    radioButtonValue: (value) {
                                      provider.txtTer.text = value as String;
                                    },
                                    selectedColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),
                            /*  const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: TextFormField(
                                controller: provider.txtSgt,
                                decoration:
                                    CustomInputs.boxInputDecorationDatePicker2(
                                        labelText: 'Siguiente visita',
                                        fc: () => selectDate('init')),
                                inputFormatters: [DateFormatter()],
                              ),
                            ), */
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Accion\nrealizada',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomRadioButton(
                                  elevation: 0,
                                  width: 115,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: UtilView.entrega,
                                  buttonValues: UtilView.entrega,
                                  buttonTextStyle: const ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 16)),
                                  radioButtonValue: (value) {
                                    provider.txtTer.text = value as String;
                                  },
                                  selectedColor: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  controller: provider.txtSgt,
                                  decoration: CustomInputs
                                      .boxInputDecorationDatePicker2(
                                          labelText: 'Siguiente visita',
                                          fc: () => selectDate('init')),
                                  inputFormatters: [DateFormatter()],
                                ),
                              ),
                            ),
                          ],
                        ),
                  */
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await dialog(
                              context,
                              'Acciones'.toUpperCase(),
                              SizedBox(
                                height: 180,
                                width: 700,
                                child: ListView.builder(
                                    itemCount: UtilView.entrega.length,
                                    itemBuilder: (_, i) {
                                      return ListTile(
                                        leading: const Icon(Icons.assignment),
                                        title: Text(UtilView.entrega[i]),
                                        onTap: () {
                                          provider.txtTer.text =
                                              UtilView.entrega[i];
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }),
                              ),
                              Icons.schedule_sharp,
                              Colors.red);
                        },
                        child: const Text('Acción\nrealizada',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Color.fromARGB(255, 62, 60, 61),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                          child: TextFormField(
                        controller: provider.txtTer,
                        enabled: false,
                        decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Comentario por omisiòn',
                            icon: Icons.assignment),
                      )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          final listAux = await provider.getObservaciones();
                          await dialog(
                              context,
                              'Observación general'.toUpperCase(),
                              SizedBox(
                                height: 250,
                                width: 700,
                                child: ListView.builder(
                                    itemCount: listAux.length,
                                    itemBuilder: (_, i) {
                                      return ListTile(
                                        leading: const Icon(Icons.assignment),
                                        title: Text(listAux[i].nomCmg),
                                        subtitle: Text(
                                          listAux[i].cICmg,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        onTap: () {
                                          provider.txtCov.text =
                                              listAux[i].codCmg;
                                          provider.txtValue.text =
                                              listAux[i].nomCmg;

                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }),
                              ),
                              Icons.schedule_sharp,
                              Colors.red);
                        },
                        child: const Text('Novedad\nen Visita',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              color: Color.fromARGB(255, 62, 60, 61),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(width: 13.5),
                      Expanded(
                          child: TextFormField(
                        controller: provider.txtValue,
                        enabled: false,
                        decoration: CustomInputs.boxInputDecoration2(
                            hint: 'Comentario por omisiòn',
                            icon: Icons.assignment),
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: provider.txtObs,
                            decoration: CustomInputs.boxInputDecoration2(
                                hint: 'Observación', icon: Icons.assignment),
                            keyboardType: TextInputType.text,
                            maxLines: 4,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(250)
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: size.width < 500 ? 2 : 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: TextFormField(
                            controller: provider.txtSgt,
                            decoration:
                                CustomInputs.boxInputDecorationDatePicker(
                                    labelText: 'Siguiente visita',
                                    fc: () => selectDate('init2'),
                                    size: 16),
                            inputFormatters: [DateFormatter()],
                          ),
                        ),
                      ),
                      const Spacer(),
                      CustomIconButton(
                          onPressed: () async {
                            final opt = await dialogCheck(
                                context,
                                'Advertencia',
                                Icons.warning,
                                Colors.red,
                                provider);
                            if (opt) {
                              await provider.saveCc0754(providerLogin.codigo);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Ruta guardada')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Transaccion cancelada')),
                              );
                            }
                          },
                          color: Colors.blueGrey,
                          text: 'Guardar ruta',
                          icon: Icons.save),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

/*   Tooltip(
                            message: 'Observacion General',
                            child: InkWell(
                              onTap: () async {
                                final listAux =
                                    await provider.getObservaciones();

                                await dialog(
                                    context,
                                    'Observación general'.toUpperCase(),
                                    SizedBox(
                                      height: 250,
                                      width: 700,
                                      child: ListView.builder(
                                          itemCount: listAux.length,
                                          itemBuilder: (_, i) {
                                            return ListTile(
                                              leading: const Icon(
                                                  Icons.person_outlined),
                                              title: Text(listAux[i].nomCmg),
                                              subtitle: Text(
                                                listAux[i].cICmg,
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                              onTap: () {
                                                provider.txtCov.text =
                                                    listAux[i].codCmg;
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          }),
                                    ),
                                    Icons.schedule_sharp,
                                    Colors.red);
                              },
                              child: const Icon(
                                Icons.font_download,
                                color: Colors.blueGrey,
                              ),
                            ))
                      */
