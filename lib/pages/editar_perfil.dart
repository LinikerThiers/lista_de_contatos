import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _emailUsuarioController = TextEditingController();
  final TextEditingController _telefoneUsuarioController =
      TextEditingController();
  final TextEditingController _dataDeAniversarioUsuarioController =
      TextEditingController();
  final TextEditingController _enderecoUsuarioController =
      TextEditingController();
  final TextEditingController _instagramUsuarioController =
      TextEditingController();
  String? profileImagePath;
  DateTime? dataNascimento;

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext modalContext) {
        final themeManager = Provider.of<ThemeManager>(modalContext);
        final isDarkMode = themeManager.isDarkMode;

        return Container(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.photo_library,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        title: Text(
                          "GALERIA".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () => Navigator.pop(modalContext),
                      ),
                      Divider(
                          height: 1,
                          color:
                              isDarkMode ? Colors.grey[700] : Colors.grey[300]),
                      ListTile(
                        leading: Icon(
                          Icons.camera_alt,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        title: Text(
                          "CAMERA".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        onTap: () => Navigator.pop(modalContext),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          "EDITAR_PERFIL".tr(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () => _showImagePickerModal(context),
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      isDarkMode ? Colors.grey[700] : Colors.grey[300],
                  backgroundImage: profileImagePath != null
                      ? FileImage(File(profileImagePath!))
                      : null,
                  child: profileImagePath == null
                      ? Icon(
                          Icons.person,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 50,
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                controller: _nomeUsuarioController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_NOME".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DIGITAR_NOME".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                controller: _emailUsuarioController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_EMAIL".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DIGITAR_EMAIL".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                controller: _telefoneUsuarioController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_TELEFONE".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DIGITAR_TELEFONE".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                controller: _dataDeAniversarioUsuarioController,
                readOnly: true,
                onTap: () async {
                  final themeManager =
                      Provider.of<ThemeManager>(context, listen: false);
                  final isDarkMode = themeManager.isDarkMode;

                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dataNascimento ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: isDarkMode
                              ? ColorScheme.dark(
                                  primary: Colors.blueGrey[400]!,
                                  secondary: Colors.white,
                                  surface: Colors.grey[900]!,
                                  onSurface: Colors.white,
                                )
                              : ColorScheme.light(
                                  primary: Colors.blueGrey,
                                  secondary: Colors.black,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                          dialogBackgroundColor:
                              isDarkMode ? Colors.grey[800]! : Colors.white,
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null) {
                    setState(() {
                      dataNascimento = pickedDate;
                      _dataDeAniversarioUsuarioController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                    });
                  }
                },
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_DATA_DE_ANIVERSARIO".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DATA_DE_ANIVERSARIO_DIGITAR".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                controller: _enderecoUsuarioController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_ENDERECO".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DIGITAR_ENDERECO".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 45,
              alignment: Alignment.center,
              child: TextField(
                maxLength: 30,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.]')),
                ],
                controller: _instagramUsuarioController,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  prefixText: '@',
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode
                          ? Colors.grey.shade600
                          : Colors.grey.shade400,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  labelText: "EDIT_PROFILE_INSTAGRAM".tr(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  hintText: "EDIT_PROFILE_DIGITAR_INSTAGRAM".tr(),
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Lógica para salvar as alterações
                },
                style: TextButton.styleFrom(
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "EDIT_PROFILE_SALVAR_ALTERACOES".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
