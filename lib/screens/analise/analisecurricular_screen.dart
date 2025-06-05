import 'package:flutter/material.dart';
import '../../models/disciplina.dart';
import '../../services/disciplina_service.dart';

class AnaliseCurricularScreen extends StatefulWidget {
  final String alunoId;
  final String alunoNome;
  final String numeroMatricula;
  final String curso;
  final String situacao;

  const AnaliseCurricularScreen({
    super.key,
    required this.alunoId,
    required this.alunoNome,
    required this.numeroMatricula,
    required this.curso,
    required this.situacao,
  });

  @override
  _AnaliseCurricularScreenState createState() => _AnaliseCurricularScreenState();
}

class _AnaliseCurricularScreenState extends State<AnaliseCurricularScreen> {
  late Future<List<Disciplina>> futureDisciplinas;
  String? periodoSelecionado;
  List<String> periodosDisponiveis = [];

  @override
  void initState() {
    super.initState();
    futureDisciplinas = DisciplinaService.getDisciplinasByAluno(widget.alunoId);
    futureDisciplinas.then((disciplinas) {
      final periodos = disciplinas.map((d) => d.periodo).toSet().toList();
      periodos.sort();
      setState(() {
        periodosDisponiveis = periodos.whereType<String>().toList();
        if (periodosDisponiveis.isNotEmpty) {
          periodoSelecionado = periodosDisponiveis.first;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Análise Curricular', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
      ),
      body: FutureBuilder<List<Disciplina>>(
        future: futureDisciplinas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final todasDisciplinas = snapshot.data ?? [];

          // Filtra as disciplinas do período selecionado
          final disciplinasFiltradas = periodoSelecionado == null
              ? []
              : todasDisciplinas.where((d) => d.periodo == periodoSelecionado).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      'Selecione o Período:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: periodoSelecionado,
                      items: periodosDisponiveis
                          .map((p) => DropdownMenuItem(
                        value: p,
                        child: Text('$pº Período'),
                      ))
                          .toList(),
                      onChanged: (novoPeriodo) {
                        setState(() {
                          periodoSelecionado = novoPeriodo;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: disciplinasFiltradas.isEmpty
                    ? const Center(child: Text('Nenhuma disciplina para este período.'))
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Código')),
                      DataColumn(label: Text('Disciplina')),
                      DataColumn(label: Text('Faltas')),
                      DataColumn(label: Text('A1')),
                      DataColumn(label: Text('A2')),
                      DataColumn(label: Text('Exame Final')),
                      DataColumn(label: Text('Média Final')),
                      DataColumn(label: Text('Situação')),
                    ],
                    rows: disciplinasFiltradas.map((disc) {
                      Color statusColor = disc.status == 'Aprovado' ? Colors.green : Colors.amber;
                      String statusText = disc.status == 'Aprovado' ? 'Aprovado' : 'Em Andamento';

                      return DataRow(cells: [
                        DataCell(Text(disc.codigo ?? '-')),
                        DataCell(Text(disc.nome ?? '-')),
                        DataCell(Text('${disc.faltas ?? '-'}')),
                        DataCell(Text('${disc.a1 ?? '-'}')),
                        DataCell(Text('${disc.a2 ?? '-'}')),
                        DataCell(Text('${disc.exameFinal ?? '-'}')),
                        DataCell(Text('${disc.mediaFinal ?? '-'}')),
                        DataCell(
                          Text(
                            statusText,
                            style: TextStyle(color: statusColor),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
