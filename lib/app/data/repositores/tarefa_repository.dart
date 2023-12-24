import 'package:bloc_puro_streams/app/data/blocs/tarefa_event.dart';
import 'package:bloc_puro_streams/app/data/models/tarefa_model.dart';

class TarefaRepository{
  final List<TarefaModel> _tarefas = [];

Future<List<TarefaModel>> getTarefas()async{
  _tarefas.addAll([
  TarefaModel(nome: "Comprar Panetone"),
  TarefaModel(nome: "fazer ginistica"),
  TarefaModel(nome: "visitar os parentes"),
  TarefaModel(nome: "jogar video game"),
  ]);
  return Future.delayed(
    const Duration(seconds: 2),
   () => _tarefas,
     );
}

Future<List<TarefaModel>> postTarefa({required TarefaModel tarefa}) async{
  _tarefas.add(tarefa);
  return Future.delayed(
    const Duration(seconds: 2),
    () => _tarefas
     );
}

Future<List<TarefaModel>> deleteTarefa({required TarefaModel tarefa}) async{
  _tarefas.remove(tarefa);
  return Future.delayed(
    const Duration(seconds: 2),
    () => _tarefas
     );
}
}


