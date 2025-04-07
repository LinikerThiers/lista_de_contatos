import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AdicionarContatoPage extends StatefulWidget {
  const AdicionarContatoPage({super.key});

  @override
  State<AdicionarContatoPage> createState() => _AdicionarContatoPageState();
}

class _AdicionarContatoPageState extends State<AdicionarContatoPage> {
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

  final ImagePicker _picker = ImagePicker();

  void _showImagePickerModal(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final isDarkMode = themeManager.isDarkMode;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext modalContext) {
        return Container(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library,
                      color: isDarkMode ? Colors.white : Colors.black),
                  title: Text("GALERIA".tr(),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black)),
                  onTap: () {
                    Navigator.pop(modalContext);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                Divider(
                    height: 1,
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.camera_alt,
                      color: isDarkMode ? Colors.white : Colors.black),
                  title: Text("CAMERA".tr(),
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black)),
                  onTap: () {
                    Navigator.pop(modalContext);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image =
          await _picker.pickImage(source: source, imageQuality: 80);

      if (image != null) {
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String fileName = path.basename(image.path);
        final File savedImage =
            await File(image.path).copy('${appDir.path}/$fileName');

        setState(() {
          profileImagePath = savedImage.path;
        });
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("ADICIONAR_CONTATO".tr(),
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const SizedBox(height: 30),
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
                    ? Icon(Icons.person,
                        color: isDarkMode ? Colors.white : Colors.black,
                        size: 50)
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInputField(
              _nomeUsuarioController, "EDIT_PROFILE_NOME", isDarkMode),
          _buildInputField(
              _emailUsuarioController, "EDIT_PROFILE_EMAIL", isDarkMode),
          _buildInputField(
              _telefoneUsuarioController, "EDIT_PROFILE_TELEFONE", isDarkMode,
              keyboardType: TextInputType.phone),
          _buildDatePickerField(context, isDarkMode),
          _buildInputField(
              _enderecoUsuarioController, "EDIT_PROFILE_ENDERECO", isDarkMode),
          _buildInputField(
            _instagramUsuarioController,
            "EDIT_PROFILE_INSTAGRAM",
            isDarkMode,
            prefixText: "@",
            maxLength: 30,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.]')),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // salvar o contato
              },
              style: TextButton.styleFrom(
                foregroundColor: isDarkMode ? Colors.black : Colors.white,
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "ADICIONAR_CONTATO".tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label,
    bool isDarkMode, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? prefixText,
    int? maxLength,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 45,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          counterText: "",
          prefixText: prefixText,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
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
          labelText: label.tr(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle:
              TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 45,
      alignment: Alignment.center,
      child: TextField(
        controller: _dataDeAniversarioUsuarioController,
        readOnly: true,
        onTap: () async {
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
                          onSurface: Colors.white,
                          surface: Colors.grey[900]!,
                        )
                      : ColorScheme.light(
                          primary: Colors.blueGrey,
                          onSurface: Colors.black,
                          surface: Colors.white,
                        ),
                  dialogBackgroundColor:
                      isDarkMode ? Colors.grey[800]! : Colors.white,
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
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
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
          labelStyle:
              TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
        ),
      ),
    );
  }
}
