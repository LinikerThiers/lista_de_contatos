import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listadecontatos/repository/contatos_back4app_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:listadecontatos/model/lista_de_contatos_model.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

class DetalhesContatoPage extends StatefulWidget {
  final ContatoBack4appModel contato;
  const DetalhesContatoPage({super.key, required this.contato});

  @override
  State<DetalhesContatoPage> createState() => _DetalhesContatoPageState();
}

class _DetalhesContatoPageState extends State<DetalhesContatoPage> {
  late TextEditingController _nomeUsuarioController;
  late TextEditingController _emailUsuarioController;
  late TextEditingController _telefoneUsuarioController;
  late TextEditingController _dataDeAniversarioUsuarioController;
  late TextEditingController _enderecoUsuarioController;
  late TextEditingController _instagramUsuarioController;
  DateTime? dataNascimento;
  String? profileImagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final contato = widget.contato;

    _nomeUsuarioController = TextEditingController(text: contato.nome ?? '');
    _emailUsuarioController = TextEditingController(text: contato.email ?? '');
    _telefoneUsuarioController =
        TextEditingController(text: contato.telefone ?? '');
    _dataDeAniversarioUsuarioController = TextEditingController(
      text: contato.aniversario?.iso != null
          ? DateFormat('dd/MM/yyyy')
              .format(DateTime.parse(contato.aniversario!.iso!))
          : '',
    );
    _enderecoUsuarioController =
        TextEditingController(text: contato.endereco ?? '');
    _instagramUsuarioController =
        TextEditingController(text: contato.instagram ?? '');
    dataNascimento = contato.aniversario?.iso != null
        ? DateTime.parse(contato.aniversario!.iso!)
        : null;
    profileImagePath = contato.imageProfile;
  }

  @override
  void dispose() {
    _nomeUsuarioController.dispose();
    _emailUsuarioController.dispose();
    _telefoneUsuarioController.dispose();
    _dataDeAniversarioUsuarioController.dispose();
    _enderecoUsuarioController.dispose();
    _instagramUsuarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato.nome ?? '',
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
                radius: 60,
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
          const SizedBox(height: 15),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton.icon(
              onPressed: () async {
                String aniversarioFormatado = (widget.contato.aniversario?.iso != null)
                    ? DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(widget.contato.aniversario!.iso!))
                    : "Não informado";
            
                Share.share("${"FRASE_TO_SHARE".tr()}\n\n"
                    "Nome: ${widget.contato.nome}\n"
                    "Telefone: ${widget.contato.telefone}\n"
                    "Email: ${widget.contato.email}\n"
                    "Aniversário: $aniversarioFormatado\n"
                    "Endereço: ${widget.contato.endereco}\n"
                    "Instagram: ${widget.contato.instagram}");
              },
              icon: FaIcon(
                FontAwesomeIcons.shareNodes,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              label: Text(
                "FRASE_TO_SHARE".tr(),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.shade600,
                      width: 1,
                    )),
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
              onPressed: salvarContatoButton,
              style: TextButton.styleFrom(
                foregroundColor: isDarkMode ? Colors.black : Colors.white,
                backgroundColor: isDarkMode ? Colors.white : Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "SALVAR".tr(),
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

  void salvarContatoButton() async {
    final contatoAtualizado = ContatoBack4appModel(
      objectId: widget.contato.objectId,
      nome: _nomeUsuarioController.text,
      email: _emailUsuarioController.text,
      telefone: _telefoneUsuarioController.text,
      aniversario: dataNascimento != null
          ? Aniversario(
              sType: 'Date',
              iso: dataNascimento!.toIso8601String(),
            )
          : null,
      endereco: _enderecoUsuarioController.text,
      instagram: _instagramUsuarioController.text,
      imageProfile: profileImagePath,
    );

    try {
      await ContatosBack4appRepository().atualizarContato(contatoAtualizado);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("CONTATO_ATUALIZADO_COM_SUCESSO".tr()),
          ),
        );

        Navigator.pop(context, contatoAtualizado);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("ERRO_AO_ATUALIZAR_CONTATO".tr()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
}
