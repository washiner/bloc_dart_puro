import 'package:bloc_puro_streams/app/data/blocs/tarefa_bloc.dart';
import 'package:bloc_puro_streams/app/data/blocs/tarefa_event.dart';
import 'package:bloc_puro_streams/app/data/blocs/tarefa_state.dart';
import 'package:bloc_puro_streams/app/data/models/tarefa_model.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({Key? key}) : super(key: key);

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  late final TarefaBloc _tarefaBloc;
  @override
  void initState() {
    super.initState();
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.imputTarefa.add(GetTarefas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc puro com Streams"),
      ),
      body: StreamBuilder<TarefaState>(
        stream: _tarefaBloc.outputTarefa,
        builder: (context, state) {
          if (state.data is TarefaLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.data is TarefaLoadedState) {
            final list = state.data?.tarefas ?? [];
            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: list.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Center(
                      child: Text(
                        list[index].nome[0],
                      ),
                    ),
                  ),
                  title: Text('tarefa ${list[index].nome}'),
                  trailing: IconButton(
                    onPressed: () {
                      _tarefaBloc.imputTarefa
                          .add(DeleteTarefa(tarefa: list[index]));
                    },
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _tarefaBloc.imputTarefa.add(
            PostTarefas(
              tarefa: TarefaModel(nome: 'Passear com Cachorro'),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tarefaBloc.imputTarefa.close();
    super.dispose();
  }
}
