import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RematriculaScreen extends StatefulWidget {
  final String alunoId;
  final String alunoNome;

  const RematriculaScreen({super.key, required this.alunoId, required this.alunoNome});

  @override
  _RematriculaScreenState createState() => _RematriculaScreenState();
}

class _RematriculaScreenState extends State<RematriculaScreen> {
  String? cursoSelecionado = 'SISTEMAS DE INFORMAÇÃO/CÂMPUS PALMAS (Matriculado)';

  Future<void> gerarEExibirPdf(String alunoNome) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Rematrícula Confirmada',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 24),
              pw.Text('Prezado(a) aluno(a),', style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 12),
              pw.Text(
                'Sua rematrícula está confirmada para o curso SISTEMAS DE INFORMAÇÃO.',
                style: pw.TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF094AB2),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'SISTEMAS DE INFORMAÇÃO',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
            child: Text(
              'Curso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF094AB2),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'Selecione o Curso',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF094AB2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RadioListTile<String>(
              title: const Text('SISTEMAS DE INFORMAÇÃO/CÂMPUS PALMAS (Matriculado)'),
              value: 'SISTEMAS DE INFORMAÇÃO/CÂMPUS PALMAS (Matriculado)',
              groupValue: cursoSelecionado,
              onChanged: (value) {
                setState(() {
                  cursoSelecionado = value;
                });
              },
              contentPadding: EdgeInsets.zero,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await gerarEExibirPdf(widget.alunoNome);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF094AB2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: const BorderSide(color: Color(0xFF00378E)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Próximo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
