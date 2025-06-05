import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../dashboard/dashboard_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final senhaController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 420,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/unitins_logo.png',
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Portal do Aluno',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Acesse utilizando seu e-mail institucional:',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: 'E-mail',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: Colors.blue.shade200,
                          width: 2,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Senha',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: Colors.blue.shade200,
                          width: 2,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 12),
                  const SizedBox(height: 20),
                  // Alinhando os textos com spaceBetween
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinha pela parte de baixo
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Preciso de Ajuda',
                        style: TextStyle(color:  Color(0xFF004093)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              final url = Uri.parse('https://www.unitins.br/PortalAluno/Account/RecuperarSenha');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              } else {
                                print('Não foi possível abrir o link');
                              }
                            },
                            child: const Text(
                              'Esqueci minha senha',
                              style: TextStyle(
                                color: Color(0xFF004093),
                                decoration: TextDecoration.underline, // Para parecer um link
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () async {
                              final url = Uri.parse('https://ava2.unitins.br/ava/login.aspx?url=/ava/Default.aspx&msg=InvalidPermission&user=Visitante');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              } else {
                                print('Não foi possível abrir o link');
                              }
                            },
                            child: const Text(
                              '🎓 AVA (Turmas 2001–2008)',
                              style: TextStyle(
                                color: Color(0xFF004093),
                                decoration: TextDecoration.underline, // Para parecer um link
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text.trim();
                        final senha = senhaController.text.trim();

                        try {
                          final aluno = await AuthService.getAlunoByEmail(email);

                          if (aluno != null && aluno['senha'] == senha) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DashboardPage(
                                  alunoId: aluno['id'],
                                  alunoNome: aluno['nome'],
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Credenciais inválidas')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro ao realizar login: $e')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004093),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Text('Entrar', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // const SizedBox(height: 12),
                  // Theme(
                  //   data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  //   child: ExpansionTile(
                  //     tilePadding: EdgeInsets.zero,
                  //     collapsedBackgroundColor: const Color(0xFF004093),
                  //     backgroundColor: const Color(0xFFEFEFEF), // leve cinza para links expandidos
                  //     title: Container(
                  //       width: double.infinity,
                  //       child: const Text(
                  //         'Acesse nossos Tutoriais e Links Úteis',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //     collapsedIconColor: Colors.white,
                  //     iconColor: const Color(0xFF004093),
                  //     childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     children: [
                  //       ListTile(
                  //         leading: const Icon(Icons.video_library, color: Color(0xFF004093)),
                  //         title: const Text('Como acessar o AVA'),
                  //         onTap: () async {
                  //           final url = Uri.parse('https://exemplo.com/tutorial-ava');
                  //           if (await canLaunchUrl(url)) {
                  //             await launchUrl(url, mode: LaunchMode.externalApplication);
                  //           }
                  //         },
                  //       ),
                  //       ListTile(
                  //         leading: const Icon(Icons.help_outline, color: Color(0xFF004093)),
                  //         title: const Text('FAQs e Suporte'),
                  //         onTap: () async {
                  //           final url = Uri.parse('https://exemplo.com/faqs');
                  //           if (await canLaunchUrl(url)) {
                  //             await launchUrl(url, mode: LaunchMode.externalApplication);
                  //           }
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Text(
                    'Desenvolvido por Esther Mota e Kaue Gloria',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
