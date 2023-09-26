import 'package:app_calculadora_imc_view/custom_components/text_label_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CalculaImcPage extends StatefulWidget {
  @override
  _CalculaImcPageState createState() => _CalculaImcPageState();
}

class _CalculaImcPageState extends State<CalculaImcPage> {
  final nomeController = TextEditingController(text: '');
  final alturaController = MoneyMaskedTextController();
  final pesoController = MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextLabelCustom('Informe o nome'),
            TextField(
              controller: nomeController,
            ),
            const SizedBox(height: 16), // Espaço em branco entre o nome e a altura/peso
            Row( // Linha para a altura e o peso
              children: [
                Expanded(
                  child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabelCustom('Informe a altura'),
                      TextField(
                        controller: alturaController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Espaço entre a altura e o peso
                Expanded(
                  child: Column(  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextLabelCustom('Informe o peso'),
                      TextField(
                        controller: pesoController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
