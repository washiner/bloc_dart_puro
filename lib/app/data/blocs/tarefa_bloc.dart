import 'dart:async';
import 'package:bloc_puro_streams/app/data/blocs/tarefa_event.dart';
import 'package:bloc_puro_streams/app/data/blocs/tarefa_state.dart';
import 'package:bloc_puro_streams/app/data/models/tarefa_model.dart';
import 'package:bloc_puro_streams/app/data/repositores/tarefa_repository.dart';

class TarefaBloc{
  final _repository = TarefaRepository();

  final StreamController<TarefaEvent> _imputTarefaController = StreamController<TarefaEvent>();
  final StreamController<TarefaState> _outputTarefaController = StreamController<TarefaState>();

  Sink<TarefaEvent> get imputTarefa => _imputTarefaController.sink;
  Stream<TarefaState> get outputTarefa => _outputTarefaController.stream;

  TarefaBloc(){
    _imputTarefaController.stream.listen(_mapEventState);
  }

  void _mapEventState(TarefaEvent event) async{
    List<TarefaModel> tarefas = [];
    _outputTarefaController.add(TarefaLoadingState());

    if(event is GetTarefas){
      tarefas = await _repository.getTarefas();
    }else if(event is PostTarefas){
      tarefas = await _repository.postTarefa(tarefa: event.tarefa);
    }else if(event is DeleteTarefa){
      tarefas = await _repository.deleteTarefa(tarefa: event.tarefa);
    }

_outputTarefaController.add(TarefaLoadedState(tarefas: tarefas));
  }
}