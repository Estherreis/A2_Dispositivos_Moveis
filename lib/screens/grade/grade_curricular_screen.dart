import 'package:flutter/material.dart';
import '../../models/disciplina.dart';
import '../../services/disciplina_service.dart';

class GradeCurricularScreen extends StatefulWidget {
  final String alunoId;

  const GradeCurricularScreen({super.key, required this.alunoId});

  @override
  _GradeCurricularScreenState createState() => _GradeCurricularScreenState();
}

class _GradeCurricularScreenState extends State<GradeCurricularScreen> {
  late Future<List<Disciplina>> futureDisciplinas;

  @override
  void initState() {
    super.initState();
    futureDisciplinas = DisciplinaService.getDisciplinasByAluno(widget.alunoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matriz Curricular' , style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
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

          final disciplinas = snapshot.data ?? [];

          // Agrupar por período
          final Map<String, List<Disciplina>> disciplinasPorPeriodo = {};
          for (var disc in disciplinas) {
            if (disc.periodo != null) {
              disciplinasPorPeriodo.putIfAbsent(disc.periodo!, () => []).add(disc);
            }
          }

          final sortedPeriodos = disciplinasPorPeriodo.keys.toList()..sort();

          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 700,
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sortedPeriodos.length,
                itemBuilder: (context, index) {
                  final periodo = sortedPeriodos[index];
                  final listaDisc = disciplinasPorPeriodo[periodo]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$periodoº Período',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DataTable(
                        headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
                        columns: const [
                          DataColumn(label: Text('Código')),
                          DataColumn(label: Text('Disciplina')),
                          DataColumn(label: Text('CH')),
                        ],
                        rows: listaDisc.map((disc) {
                          return DataRow(
                            cells: [
                              DataCell(Text(disc.codigo ?? '-')),
                              DataCell(Text(disc.nome ?? '-')),
                              DataCell(Text('${disc.ch ?? '-'}')),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
