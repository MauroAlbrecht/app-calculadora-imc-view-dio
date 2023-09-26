import 'package:app_calculadora_imc_view/models/pessoa.dart';
import 'package:app_calculadora_imc_view/models/resulado_imc.dart';
import 'package:app_calculadora_imc_view/services/calcula_imc_service.dart';

class ResultadoImcServide {

  var calculadoraImcService = CalculadoraImcService();

  List<ResultadoImc> _resultados = [];

  List<ResultadoImc> get getResultados => _resultados;

  void add(Pessoa pessoa) {

    var resultadoImc = calculadoraImcService.calculaIMC(pessoa);
    var msgResultadoImc = calculadoraImcService.getMsgResultado(resultadoImc);

    _resultados.add(ResultadoImc(pessoa, resultadoImc, msgResultadoImc));
  }

  void remover(ResultadoImc resultadoImc) {
    _resultados.remove(resultadoImc);
  }
}
