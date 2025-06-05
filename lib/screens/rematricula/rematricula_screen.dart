import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw; // pacote para gerar PDF
import 'package:printing/printing.dart'; // para mostrar/baixar o pdf
import '../../models/disciplina.dart';
import '../../services/disciplina_service.dart'; // criaremos método para enviar

class RematriculaScreen extends StatefulWidget {
  final String alunoId;
  final String alunoNome;

  const RematriculaScreen({super.key, required this.alunoId, required this.alunoNome});

  @override
  _RematriculaScreenState createState() => _RematriculaScreenState();
}

class _RematriculaScreenState extends State<RematriculaScreen> {
  late Future<List<Disciplina>> futureDisciplinas;
  Map<String, bool> selecionadas = {};
  final int periodoRematricula = 3; // exemplo fixo para período 3

  @override
  void initState() {
    super.initState();
    futureDisciplinas = DisciplinaService.getDisciplinasPorPeriodo(widget.alunoId, periodoRematricula);
  }

  void toggleSelecionada(String codigo) {
    setState(() {
      selecionadas[codigo] = !(selecionadas[codigo] ?? false);
    });
  }

  Future<void> gerarEExibirPdf(List<Disciplina> disciplinas, String alunoNome) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Título do PDF
            pw.Center(
              child: pw.Text(
                'Rematrícula - Período $periodoRematricula',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 20),

            // Detalhes do aluno
            pw.Text(
              'Aluno: $alunoNome',
              style: pw.TextStyle(fontSize: 18),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Curso: Sistemas de Informação', // Substitua pelo nome do curso do aluno
              style: pw.TextStyle(fontSize: 18),
            ),
            pw.SizedBox(height: 20),

            // Disciplinas selecionadas
            pw.Text(
              'Disciplinas selecionadas:',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),

            // Lista de disciplinas selecionadas
            pw.ListView.builder(
              itemCount: disciplinas.length,
              itemBuilder: (context, index) {
                final disc = disciplinas[index];
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 8),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        '${disc.codigo} - ${disc.nome}',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rematrícula Online' , style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
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

          if (disciplinas.isEmpty) {
            return const Center(child: Text('Nenhuma disciplina disponível para rematrícula.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: disciplinas.map((disc) {
                    return CheckboxListTile(
                      title: Text('${disc.codigo} - ${disc.nome}'),
                      value: selecionadas[disc.codigo] ?? false,
                      onChanged: (_) => toggleSelecionada(disc.codigo ?? ''),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () async {
                    final selecionadasList = disciplinas.where((disc) => selecionadas[disc.codigo] == true).toList();

                    if (selecionadasList.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecione ao menos uma disciplina.')),
                      );
                      return;
                    }

                    await gerarEExibirPdf(selecionadasList, widget.alunoNome);
                    Navigator.pop(context);
                  },
                  child: const Text('Confirmar Rematrícula'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
