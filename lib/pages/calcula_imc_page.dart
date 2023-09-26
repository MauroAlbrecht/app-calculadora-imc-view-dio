import 'package:app_calculadora_imc_view/custom_components/modal_custom.dart';
import 'package:app_calculadora_imc_view/custom_components/text_label_custom.dart';
import 'package:app_calculadora_imc_view/models/pessoa.dart';
import 'package:app_calculadora_imc_view/models/resulado_imc.dart';
import 'package:app_calculadora_imc_view/services/resultado_imc_service.dart';
import 'package:app_calculadora_imc_view/utils/double_utils.dart';
import 'package:app_calculadora_imc_view/utils/string_utils.dart';
import 'package:app_calculadora_imc_view/utils/validator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class CalculaImcPage extends StatefulWidget {
  @override
  _CalculaImcPageState createState() => _CalculaImcPageState();
}

class _CalculaImcPageState extends State<CalculaImcPage> {
  final nomeController = TextEditingController(text: '');
  final alturaController = MoneyMaskedTextController();
  final pesoController = MoneyMaskedTextController();
  final resultadoImcService = ResultadoImcServide();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextLabelCustom('Informe o nome'),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: nomeController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Informe esse campo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                // Linha para a altura e o peso
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelCustom('Informe a altura'),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: alturaController,
                          validator: (value) {
                            if (!ValidatorUtils.isCampoValido(value)) {
                              return 'Informe esse campo.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextLabelCustom('Informe o peso'),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: pesoController,
                          validator: (value) {
                            if (!ValidatorUtils.isCampoValido(value)) {
                              return 'Informe esse campo.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      adicionarImc();
                    },
                    child: const Text("Adicionar"),
                  ),
                ],
              ),
              const TextLabelCustom('Resultados'),
              Expanded(
                  child: resultadoImcService.getResultados.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nenhum resultado para exibir, informe os dados e toque em Adicionar'),
                      )
                      : ListView.builder(
                          itemCount: resultadoImcService.getResultados.length,
                          itemBuilder: (BuildContext context, int index) {
                            ResultadoImc resultado = resultadoImcService.getResultados[index];

                            return ListTile(
                              isThreeLine: true,
                              title: Text(resultado.pessoa.nome), // Acesse o nome da pessoa a partir do objeto ResultadoImc
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Resultado: ${resultado.resultado}',
                                    style: const TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  Text('IMC: ${resultado.imc.toStringAsFixed(2)}, Altura: ${resultado.pessoa.altura.toStringAsFixed(2)}, Peso: ${resultado.pessoa.peso.toStringAsFixed(2)}', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                              trailing: InkWell(
                                child: const Icon(Icons.delete_forever_outlined, color: Colors.red,),
                                onTap: () {
                                  _showCustomModal(context, resultado);
                                },
                              ),
                            );
                          },
                        )),
            ],
          ),
        ),
      ),
    );
  }

  void adicionarImc() {
    if (_formKey.currentState != null) {
      bool isValid = _formKey.currentState!.validate();

      if (!isValid) {
        return;
      }
      var nome = StringUtils.capitalizeAllWord(nomeController.text);
      var altura = DoubleUtils().transformaStringEmNum(alturaController.text);
      var peso = DoubleUtils().transformaStringEmNum(pesoController.text);

      var pessoa = Pessoa(nome, altura, peso);

      resultadoImcService.add(pessoa);

      limparCamposNaTela();

      setState(() {});
    }
  }

  void limparCamposNaTela() {
    nomeController.clear();
    alturaController.clear();
    pesoController.clear();
  }

  void _showCustomModal(BuildContext context, ResultadoImc resulado) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ModalCustom(resulado.pessoa.nome);
      },
    ).then((value) {
      // Aqui você pode tratar a resposta do modal (valor 'Sim' ou 'Não')
      if (value == 'Sim') {
        resultadoImcService.remover(resulado);
        setState(() {});
      }
    });
  }
}
