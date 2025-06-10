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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFF8F8F8),
          elevation: 0,
          automaticallyImplyLeading: false,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFE7E7E7), width: 1),
          ),
          title: Row(
            children: [
              SizedBox(
                height: 80,
                child: Center(
                  child: Image.asset(
                    'assets/images/unitins_logo.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Container()),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.account_circle, color: Color(0xFF777777), size: 20),
                    const SizedBox(width: 6),
                    Text(
                      alunoNome,
                      style: const TextStyle(color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Color(0xFF094AB2)), // ícone "fa-sign-out"
                      SizedBox(width: 8),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: const [
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Color(0xFF777777)),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFDDDDDD)),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: const TabBar(
                  isScrollable: true,
                  labelColor: Color(0xFF094AB2),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color(0xFFDDDDDD),
                  indicatorWeight: 1.5,
                  tabs: [
                    Tab(text: 'Portal do Aluno'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            // aqui você copia o .map dos cards normalmente
                            ...cards.where((card) => card['titulo'] != 'GRADE CURRICULAR').map((card) {
                              return SizedBox(
                                width: 280,
                                height: 190,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      // borda azul esquerda
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF314BB1),
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // conteúdo do card
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              card['titulo'] as String,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF094AB2),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Expanded(
                                              child: Text(
                                                card['descricao'] as String,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                    color: Color(0xFF707070)
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: OutlinedButton(
                                                onPressed: card['action'] as VoidCallback,
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: const Color(0xFF005DFF), // cor da letra
                                                  side: const BorderSide(color: Color(0xFFD5D5D5)), // borda
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4), // menos arredondado
                                                  ),
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
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
