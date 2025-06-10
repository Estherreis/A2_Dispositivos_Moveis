import 'dart:math';
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

  @override
  void initState() {
    super.initState();
    futureDisciplinas = DisciplinaService.getDisciplinasByAluno(widget.alunoId);
  }

  String gerarCpfFake() {
    final rand = Random();
    String digitos(int qtd) =>
        List.generate(qtd, (_) => rand.nextInt(10).toString()).join();
    return '${digitos(3)}.${digitos(3)}.${digitos(3)}-${digitos(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          elevation: 0,
          automaticallyImplyLeading: true,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFE7E7E7), width: 1),
          ),
          title: Row(
            children: [
              SizedBox(
                height: 60,
                child: Center(
                  child: Image.asset(
                    'assets/images/unitins_logo.png',
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(child: SizedBox()),
            ],
          ),
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

          final disciplinas = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Faixa azul
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF094AB2),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: const Text(
                          'SISTEMAS DE INFORMAÇÃO',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // H1
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Text(
                          'Análise Curricular',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),

                      // Tabela centralizada com borda azul
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF094AB2), width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all(const Color(0xFF094AB2)),
                            headingTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            dataTextStyle: const TextStyle(
                              color: Color(0xFF094AB2), // texto das células
                              fontSize: 14,
                            ),
                            columns: const [
                              DataColumn(label: Text('Matrícula')),
                              DataColumn(label: Text('CPF')),
                              DataColumn(label: Text('Nome')),
                              DataColumn(label: Text('Curso')),
                              DataColumn(label: Text('Modalidade')),
                              DataColumn(label: Text('Status')),
                            ],
                            rows: [
                              DataRow(cells: [
                                DataCell(Text(widget.numeroMatricula)),
                                DataCell(Text(gerarCpfFake())),
                                DataCell(Text(widget.alunoNome)),
                                const DataCell(Text('Sistemas de Informação')),
                                const DataCell(Text('Câmpus Palmas')),
                                const DataCell(Text('Matriculado')),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
