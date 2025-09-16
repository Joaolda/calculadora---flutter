import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Expressões',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculadoraScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  TextEditingController controller = TextEditingController();
  String resultado = '';

  void calcular() {
    String expressaoString = controller.text.trim();

    if (expressaoString.isEmpty) {
      setState(() {
        resultado = 'Digite uma expressão';
      });
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expressaoString);
      ContextModel cm = ContextModel();
      double res = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        if (res == res.toInt().toDouble()) {
          resultado = res.toInt().toString();
        } else {
          resultado = res.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      });
    } catch (e) {
      setState(() {
        if (e.toString().contains('Division by zero')) {
          resultado = 'Erro: Divisão por zero não é permitida.';
        } else {
          resultado = 'Erro: Expressão inválida.';
        }
      });
    }
  }

  void onButtonPressed(String value) {
    setState(() {
      if (controller.text == '0' || controller.text == 'Digite uma expressão' || controller.text.startsWith('Erro')) {
        controller.text = value;
      } else {
        controller.text += value;
      }
    });
  }

  void onClearPressed() {
    setState(() {
      controller.clear();
      resultado = '';
    });
  }

  void onBackspacePressed() {
    setState(() {
      if (controller.text.isNotEmpty) {
        controller.text = controller.text.substring(0, controller.text.length - 1);
      }
    });
  }

  Widget buildButton(String text, {Color? color, Color? textColor, VoidCallback? onPressed}) {
    return Container(
      margin: EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPressed ?? () => onButtonPressed(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.grey[100],
          foregroundColor: textColor ?? Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.05),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Calculadora de Expressões',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            // Display Area
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Digite a expressão',
                hintText: 'Ex: 2 * 5 + sin(pi/4)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[600]!),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 12),
                  if (resultado.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: resultado.startsWith('Erro') ? Colors.grey[100] : Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: resultado.startsWith('Erro') ? Colors.grey[300]! : Colors.grey[200]!,
                        ),
                      ),
                      child: Text(
                        resultado,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: resultado.startsWith('Erro') ? Colors.grey[600] : Colors.grey[700],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Buttons Grid
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Row 1: Clear, Backspace, Functions
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton(
                              'C',
                              color: Colors.grey[300],
                              textColor: Colors.grey[800],
                              onPressed: onClearPressed,
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              '⌫',
                              color: Colors.grey[300],
                              textColor: Colors.grey[800],
                              onPressed: onBackspacePressed,
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              'sin',
                              color: Colors.grey[400],
                              textColor: Colors.grey[800],
                              onPressed: () => onButtonPressed('sin('),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              'cos',
                              color: Colors.grey[400],
                              textColor: Colors.grey[800],
                              onPressed: () => onButtonPressed('cos('),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 2: Numbers and basic operators
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton('7'),
                          ),
                          Expanded(
                            child: buildButton('8'),
                          ),
                          Expanded(
                            child: buildButton('9'),
                          ),
                          Expanded(
                            child: buildButton(
                              '/',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('/'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 3
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton('4'),
                          ),
                          Expanded(
                            child: buildButton('5'),
                          ),
                          Expanded(
                            child: buildButton('6'),
                          ),
                          Expanded(
                            child: buildButton(
                              '*',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('*'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 4
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton('1'),
                          ),
                          Expanded(
                            child: buildButton('2'),
                          ),
                          Expanded(
                            child: buildButton('3'),
                          ),
                          Expanded(
                            child: buildButton(
                              '-',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('-'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 5
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton('0'),
                          ),
                          Expanded(
                            child: buildButton('.'),
                          ),
                          Expanded(
                            child: buildButton(
                              'π',
                              color: Colors.grey[600],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('pi'),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              '+',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('+'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 6: Advanced functions
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: buildButton(
                              '√',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('sqrt('),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              '^',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('^'),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              '(',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed('('),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              ')',
                              color: Colors.grey[500],
                              textColor: Colors.white,
                              onPressed: () => onButtonPressed(')'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Row 7: Equals button
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.all(2),
                              child: ElevatedButton(
              onPressed: calcular,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[700],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  elevation: 2,
                                  shadowColor: Colors.black12,
                                ),
                                child: Text(
                                  '=',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: buildButton(
                              'tan',
                              color: Colors.grey[400],
                              textColor: Colors.grey[800],
                              onPressed: () => onButtonPressed('tan('),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
