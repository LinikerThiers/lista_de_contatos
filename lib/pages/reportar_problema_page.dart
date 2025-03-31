import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';

class ReportarProblemaPage extends StatefulWidget {
  const ReportarProblemaPage({super.key});

  @override
  State<ReportarProblemaPage> createState() => _ReportarProblemaPageState();
}

class _ReportarProblemaPageState extends State<ReportarProblemaPage> {
  final TextEditingController _problemController = TextEditingController();
  final int _maxLength = 200;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text("RELATAR_PROBLEMA".tr(),
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _problemController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "DESCREVA_PROBLEMA".tr(),
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[300] : Colors.black,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.grey[300]! : Colors.black,
                      width: 1,
                    ),
                  ),
                  counterText: '${_problemController.text.length}/$_maxLength',
                  counterStyle: TextStyle(
                    color: _problemController.text.length > _maxLength
                        ? Colors.red
                        : isDarkMode
                            ? Colors.grey[300]
                            : Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[300] : Colors.black,
                ),
                maxLines: 10,
                minLines: 10,
                keyboardType: TextInputType.multiline,
                maxLength: _maxLength,
                buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) {
                  return Text(
                    '$currentLength/$maxLength',
                    style: TextStyle(
                      color: currentLength > maxLength!
                          ? Colors.red
                          : isDarkMode
                              ? Colors.grey[300]
                              : Colors.black,
                    ),
                  );
                },
                onChanged: (text) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _problemController.text.trim().isEmpty ||
                        _problemController.text.length > _maxLength
                    ? null
                    : () {
                        // Lógica para enviar o problema reportado
                      },
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'ENVIAR'.tr(),
                  style: TextStyle(
                      color: isDarkMode ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
