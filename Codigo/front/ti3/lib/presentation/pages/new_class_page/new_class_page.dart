import 'package:flutter/material.dart';
import 'package:ti3/utils/gira_colors.dart';

class NewClassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: GiraColors.loginBoxColor,
        title: const Text('Cadastro de Turma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Código',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  label: Text(
                    'Informe o código...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Senha',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  label: Text(
                    'Cria uma senha...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 450),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: GiraColors.loginBoxColor),
                    ),
                    minimumSize: Size(300, 50),
                    
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(color: GiraColors.loginBoxColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
