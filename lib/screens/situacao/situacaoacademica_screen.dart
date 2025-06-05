import 'package:flutter/material.dart';

class SituacaoAcademicaScreen extends StatelessWidget {
  final String alunoId;
  final String alunoNome;
  final String numeroMatricula;
  final String curso;
  final String situacao;
  final Map<String, bool> documentos;

  const SituacaoAcademicaScreen({
    super.key,
    required this.alunoId,
    required this.alunoNome,
    required this.numeroMatricula,
    required this.curso,
    required this.situacao,
    required this.documentos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Situação Acadêmica' , style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Situação Acadêmica',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            ),
            const SizedBox(height: 20),
            Text('Nº de Matrícula: $numeroMatricula', style: TextStyle(fontSize: 16)),
            Text('Nome: $alunoNome', style: TextStyle(fontSize: 16)),
            Text('Curso: $curso', style: TextStyle(fontSize: 16)),
            Text('Situação: $situacao', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),


            Text(
              'Documentos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            ),
            const SizedBox(height: 10),


            Expanded(
              child: ListView(
                children: documentos.keys.map((doc) {
                  bool entregue = documentos[doc] ?? false;
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(doc, style: TextStyle(fontSize: 16)),
                      trailing: Icon(
                        entregue ? Icons.check_circle : Icons.cancel,
                        color: entregue ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
