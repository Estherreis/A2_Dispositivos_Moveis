import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../models/disciplina.dart';
import '../../services/disciplina_service.dart';
import 'dart:convert';

class BoletimScreen extends StatefulWidget {
  final String alunoId;

  const BoletimScreen({super.key, required this.alunoId});

  @override
  _BoletimScreenState createState() => _BoletimScreenState();
}

class _BoletimScreenState extends State<BoletimScreen> {
  late Future<List<Disciplina>> futureDisciplinas;
  String? periodoSelecionado;
  List<String> periodosDisponiveis = [];

  @override
  void initState() {
    super.initState();
    futureDisciplinas = DisciplinaService.getDisciplinasByAluno(widget.alunoId);
    futureDisciplinas.then((disciplinas) {
      // Extrai períodos únicos e ordena
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

  void gerarPdf(BuildContext context, List<Disciplina> disciplinas) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Boletim Acadêmico - Sistemas de Informação',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text('Disciplinas do Semestre Letivo',
                  style: pw.TextStyle(fontSize: 14, color: PdfColors.blue)),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: [
                  'Período', 'Código', 'Disciplina', 'Faltas', 'A1', 'A2',
                  'Exame Final', 'Média Final', 'Situação'
                ],
                data: disciplinas.map((disc) => [
                  disc.periodo ?? '-',
                  disc.codigo ?? '-',
                  utf8.decode(disc.nome!.runes.toList()), // corrigido!
                  '${disc.faltas ?? '-'}',
                  '${disc.a1 ?? '-'}',
                  '${disc.a2 ?? '-'}',
                  '${disc.exameFinal ?? '-'}',
                  '${disc.mediaFinal ?? '-'}',
                  disc.status ?? '-',
                ]).toList(),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
                cellStyle: const pw.TextStyle(fontSize: 10),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                cellAlignment: pw.Alignment.centerLeft,
                cellPadding: const pw.EdgeInsets.all(4),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
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

          final todasDisciplinas = snapshot.data ?? [];

          final List<Disciplina> disciplinasFiltradas = periodoSelecionado == null
              ? []
              : todasDisciplinas.where((d) => d.periodo == periodoSelecionado).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Text(
                      'Selecione o Período:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: periodoSelecionado,
                      style: const TextStyle(color: Colors.white),
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
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
                child: Text(
                  'Boletim Acadêmico - SISTEMAS DE INFORMAÇÃO',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  'Disciplinas do Semestre Letivo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF094AB2),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DataTable(
                        headingRowColor: MaterialStateProperty.all(Color(0xFFF8F8F8)),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        columns: const [
                          DataColumn(label: Text('Período')),
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
                          return DataRow(cells: [
                            DataCell(Text(disc.periodo ?? '-')),
                            DataCell(Text(disc.codigo ?? '-')),
                            DataCell(Text(
                                disc.nome != null ? utf8.decode(disc.nome!.runes.toList()) : '-')),
                            DataCell(Text('${disc.faltas ?? '-'}')),
                            DataCell(Text('${disc.a1 ?? '-'}')),
                            DataCell(Text('${disc.a2 ?? '-'}')),
                            DataCell(Text('${disc.exameFinal ?? '-'}')),
                            DataCell(Text('${disc.mediaFinal ?? '-'}')),
                            DataCell(Text(disc.status ?? '-')),
                          ]);
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => gerarPdf(context, disciplinasFiltradas),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF094AB2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: const BorderSide(color: Color(0xFF00378E)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('Imprimir'),
                      ),
                    ],
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
