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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF094AB2),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Text(
                'SISTEMAS DE INFORMAÇÃO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Situação Acadêmica',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF094AB2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        buildInfoField(
                          label: 'Nº de Matrícula:',
                          value: numeroMatricula,
                        ),
                        buildInfoField(label: 'Nome:', value: alunoNome),
                        buildInfoField(label: 'Curso:', value: curso),
                        buildInfoField(label: 'Situação:', value: situacao),
                        const SizedBox(height: 24),

                        // Documentos
                        buildInfoField(
                          label: 'Documentos:',
                          valueWidget: Column(
                            children:
                                documentos.entries.map((entry) {
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          entry.value
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color:
                                              entry.value
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            entry.key,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Campo visual padrão com rótulo à esquerda e conteúdo à direita em caixa
  Widget buildInfoField({
    required String label,
    String? value,
    Widget? valueWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child:
                valueWidget ??
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    value ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
