import 'package:flutter/material.dart';
import '../boletim/boletim_screen.dart';
import '../grade/grade_curricular_screen.dart';
import '../rematricula/rematricula_screen.dart';
import '../situacao/situacaoacademica_screen.dart';
import '../analise/analisecurricular_screen.dart';

class DashboardPage extends StatelessWidget {
  final String alunoId;
  final String alunoNome;

  const DashboardPage({
    super.key,
    required this.alunoId,
    required this.alunoNome,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cards = [
      {
        'titulo': 'BOLETIM (SEMESTRE ATUAL)',
        'descricao': 'Desempenho nas disciplinas do semestre atual',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BoletimScreen(alunoId: alunoId),
            ),
          );
        },
      },
      {
        'titulo': 'GRADE CURRICULAR',
        'descricao': 'Selecione um curso e veja as disciplinas distribuídas por período.',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GradeCurricularScreen(alunoId: alunoId),
            ),
          );
        },
      },
      {
        'titulo': 'REMATRÍCULA ONLINE',
        'descricao': 'Fazer a rematrícula nos semestres posteriores, conforme calendário acadêmico. Emissão da declaração de vínculo.',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RematriculaScreen(alunoId: alunoId, alunoNome: alunoNome),
            ),
          );
        },
      },
      {
        'titulo': 'SITUAÇÃO ACADÊMICA',
        'descricao': 'Veja a sua situação junto à secretaria e demais departamentos da unitins.',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SituacaoAcademicaScreen(
                alunoId: alunoId,
                alunoNome: alunoNome,
                numeroMatricula: '2022201100100456',
                curso: 'Sistemas de Informação',
                situacao: 'Matriculado',
                documentos: {
                  'Foto': true,
                  'Carteira de Identidade/RG': false,
                  'Certidão de Nascimento/Casamento': true,
                  'Histórico Escolar - Ensino Médio': false,
                  'Certificado Militar/Reservista': true,
                  'CPF (CIC)': true,
                  'Diploma/Certificado Registrado': false,
                  'Comprovante de Vacina': true,
                  'Título de Eleitor': false,
                  'Comprovante de Votação': true,
                },
              ),
            ),
          );
        },
      },
      {
        'titulo': 'ANÁLISE CURRICULAR',
        'descricao': 'Análise curricular completa',
        'action': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AnaliseCurricularScreen(
                alunoId: alunoId,
                alunoNome: alunoNome,
                numeroMatricula: '2022201100100456',
                curso: 'Sistemas de Informação',
                situacao: 'Matriculado',
              ),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Secretaria', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                alunoNome,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: cards.map((card) {
              return SizedBox(
                width: 280,
                height: 190,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.blue.shade900,
                          width: 6,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card['titulo'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            card['descricao'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: OutlinedButton(
                            onPressed: card['action'] as VoidCallback,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue.shade900,
                              side: BorderSide(color: Colors.blue.shade900),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text('Acessar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
