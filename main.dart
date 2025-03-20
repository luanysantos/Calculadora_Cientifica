import 'package:flutter/material.dart'; // Importa a biblioteca principal do Flutter para criação da interface gráfica do aplicativo.
import 'package:math_expressions/math_expressions.dart'; // Importa a biblioteca 'math_expressions' para interpretar expressões matemáticas e realizar cálculos.
import 'dart:math'; // Importa a biblioteca 'dart:math' para utilizar funções matemáticas avançadas, como raiz quadrada e logaritmos.

// Função principal que inicia o aplicativo.
void main() {
  runApp(CalculatorApp()); // Chama a função runApp para rodar o aplicativo e passa CalculatorApp como argumento.
}

// Classe que representa o aplicativo da calculadora, sendo um StatelessWidget (sem estado).
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key}); // Construtor da classe, que utiliza a chave super para gerenciamento da chave de estado.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desativa o banner de debug que aparece no canto superior direito da tela.
      home: CalculatorScreen(), // Define a tela inicial do aplicativo como a CalculatorScreen, onde o layout da calculadora será exibido.
    );
  }
}

// Classe que representa a tela da calculadora, sendo um StatefulWidget (possui estado).
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key}); // Construtor da classe, usando a chave super.

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState(); // Cria o estado associado à CalculatorScreen, onde a lógica e o estado da calculadora são gerenciados.
}

// Classe que gerencia o estado da calculadora.
class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = ""; // Variável que armazena a entrada do usuário, ou seja, o que ele digita na calculadora.
  String output = "0"; // Variável que armazena o resultado da expressão ou operação matemática a ser exibido.

  // Função chamada sempre que um botão da calculadora é pressionado.
  void onButtonPressed(String value) {
    setState(() { // Atualiza o estado da tela para refletir mudanças sempre que um botão é pressionado.
      if (value == "C") { // Se o botão pressionado for "C" (limpar), limpa a entrada e o resultado.
        input = "";
        output = "0";
      } else if (value == "⌫") { // Se o botão pressionado for "⌫" (apagar), remove o último caractere da entrada.
        if (input.isNotEmpty) { // Verifica se há algum texto na entrada antes de tentar apagar.
          input = input.substring(0, input.length - 1); // Remove o último caractere da string 'input'.
        }
      } else if (value == "=") { // Se o botão pressionado for "=" (igual), calcula o resultado da expressão.
        try {
          String finalInput = input.replaceAll("×", "*").replaceAll("÷", "/"); // Substitui os símbolos '×' por '*' e '÷' por '/' para compatibilidade com a avaliação.
          Parser p = Parser(); // Cria uma instância da classe Parser para analisar a expressão.
          Expression exp = p.parse(finalInput); // Converte a entrada do usuário (como string) para uma expressão matemática.
          ContextModel cm = ContextModel(); // Cria um modelo de contexto necessário para a avaliação da expressão.
          double eval = exp.evaluate(EvaluationType.REAL, cm); // Avalia a expressão e obtém o resultado como um número real.
          output = eval.toString(); // Converte o resultado da avaliação para string e atualiza a saída.
        } catch (e) { // Se ocorrer um erro (como sintaxe inválida), exibe "Erro" no lugar do resultado.
          output = "Erro";
        }
      } else if (value == "√") { // Se o botão pressionado for "√" (raiz quadrada), calcula a raiz quadrada do número atual na entrada.
        try {
          double num = double.parse(input); // Converte a entrada para número.
          output = sqrt(num).toString(); // Calcula a raiz quadrada do número e exibe o resultado.
        } catch (e) { // Se ocorrer um erro (por exemplo, entrada inválida), exibe "Erro".
          output = "Erro";
        }
      } else if (value == "x²") { // Se o botão pressionado for "x²" (quadrado), calcula o quadrado do número atual na entrada.
        try {
          double num = double.parse(input); // Converte a entrada para número.
          output = pow(num, 2).toString(); // Calcula o quadrado do número e exibe o resultado.
        } catch (e) { // Se ocorrer um erro, exibe "Erro".
          output = "Erro";
        }
      } else if (value == "log") { // Se o botão pressionado for "log" (logaritmo natural), calcula o logaritmo natural (ln) do número.
        try {
          double num = double.parse(input); // Converte a entrada para número.
          output = log(num).toString(); // Calcula o logaritmo natural do número e exibe o resultado.
        } catch (e) { // Se ocorrer um erro, exibe "Erro".
          output = "Erro";
        }
      } else if (value == "sin") { // Se o botão pressionado for "sin" (seno), calcula o seno do número (em graus).
        try {
          double num = double.parse(input); // Converte a entrada para número.
          output = sin(num * pi / 180).toString(); // Converte graus para radianos e calcula o seno.
        } catch (e) { // Se ocorrer um erro, exibe "Erro".
          output = "Erro";
        }
      } else if (value == "cos") { // Se o botão pressionado for "cos" (cosseno), calcula o cosseno do número (em graus).
        try {
          double num = double.parse(input); // Converte a entrada para número.
          output = cos(num * pi / 180).toString(); // Converte graus para radianos e calcula o cosseno.
        } catch (e) { // Se ocorrer um erro, exibe "Erro".
          output = "Erro";
        }
      } else { // Se o valor pressionado não for um operador ou comando especial, ele é adicionado à entrada.
        input += value; // Concatena o valor pressionado ao texto da entrada.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850], // Define a cor de fundo da tela como um tom de cinza escuro.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Alinha os elementos na parte inferior da tela.
        children: [
          Container(
            padding: EdgeInsets.all(20), // Adiciona um padding (espaçamento) de 20 pixels ao redor da entrada.
            alignment: Alignment.centerRight, // Alinha a entrada do usuário à direita.
            child: Text(
              input, // Exibe o texto digitado pelo usuário.
              style: TextStyle(fontSize: 32, color: Colors.white), // Define o estilo do texto da entrada (tamanho e cor).
            ),
          ),
          Container(
            padding: EdgeInsets.all(20), // Adiciona um padding de 20 pixels ao redor do resultado.
            alignment: Alignment.centerRight, // Alinha o resultado à direita.
            child: Text(
              output, // Exibe o resultado da operação.
              style: TextStyle(fontSize: 48, color: Colors.white), // Define o estilo do texto do resultado (tamanho e cor).
            ),
          ),
          Divider(color: Colors.white), // Adiciona uma linha divisória de cor branca entre a entrada/saída e os botões.
          buildButtonGrid(), // Chama o método que cria a grade de botões da calculadora.
        ],
      ),
    );
  }

  // Método que cria a grade de botões da calculadora.
  Widget buildButtonGrid() {
    List<String> buttons = [ // Lista de todos os botões disponíveis na calculadora.
      "C", "%", "÷", "×",
      "7", "8", "9", "-",
      "4", "5", "6", "+",
      "1", "2", "3", "=",
      "0", ".", "⌫", "√",
      "x²", "log", "sin", "cos",
    ];

    return GridView.builder(
      shrinkWrap: true, // Define que a grade de botões não vai ocupar mais espaço do que o necessário.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Define que serão 4 botões por linha.
        childAspectRatio: 1.3, // Define a proporção de largura/altura dos botões.
      ),
      itemCount: buttons.length, // Número total de botões na lista.
      itemBuilder: (context, index) {
        return buildButton(buttons[index]); // Chama o método para criar um botão para cada item na lista.
      },
    );
  }

  // Método que constrói cada botão da calculadora.
  Widget buildButton(String text) {
    bool isOperator = "+-×÷=%C⌫=√x²logsin cos".contains(text); // Verifica se o botão é um operador ou um botão especial.
    return GestureDetector(
      onTap: () => onButtonPressed(text), // Chama a função 'onButtonPressed' quando o botão é pressionado.
      child: Container(
        margin: EdgeInsets.all(8), // Adiciona margem de 8 pixels ao redor de cada botão.
        decoration: BoxDecoration(
          color: isOperator ? Colors.red : Colors.grey[700], // Define a cor do botão: vermelha para operadores e cinza para números.
          borderRadius: BorderRadius.circular(10), // Define um arredondamento nos cantos do botão.
        ),
        child: Center(
          child: Text(
            text, // Exibe o texto do botão.
            style: TextStyle(
              fontSize: 28, // Define o tamanho da fonte do botão.
              color: Colors.white, // Define a cor do texto como branco.
              fontWeight: FontWeight.bold, // Define o peso da fonte como negrito.
            ),
          ),
        ),
      ),
    );
  }
}