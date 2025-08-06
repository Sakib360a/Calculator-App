import 'package:flutter/material.dart';

import '../widgets/number_button.dart';
import '../widgets/operator_button.dart';
import '../widgets/icon_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _input = '0';
  String _operation = '0';
  double num1 = 0;
  double num2 = 0;
  double result = 0;
  bool _isResultDisplayed = false;

  void ButtonPress(String value) {
    print('Pressed: $value');
    setState(() {
      // Clear everything and reset the calculator
      if (value == 'AC') {
        _input = '0';
        _output = '0';
        _operation = '0';
        num1 = 0;
        num2 = 0;
        _isResultDisplayed = false;
      }
      // Clear just the current input and output
      else if (value == 'C') {
        _input = '0';
        _output = '0';
      }
      // Handle operator (+, -, ×, ÷)
      else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        if (_operation != '0' && !_isResultDisplayed) {
          // If there is a previous operation, calculate the result so far
          num2 = double.tryParse(_input) ?? 0;
          switch (_operation) {
            case '+':
              num1 += num2;
              break;
            case '-':
              num1 -= num2;
              break;
            case '×':
              num1 *= num2;
              break;
            case '÷':
              if (num2 != 0) {
                num1 /= num2;
              } else {
                _output = 'Error';
                _input = '0';
                _operation = '0';
                return;
              }
              break;
          }
          _output = num1.toString() + value;
        } else {
          // First time operator pressed or after result
          if (_isResultDisplayed) {
            num1 = double.tryParse(_input) ?? 0;
            _output = num1.toString() + value;
          } else {
            num1 = double.tryParse(_input) ?? 0;
            _output = _input + value;
          }
        }

        // Prepare for the next input and store the operation
        _input = '0';
        _operation = value;
        _isResultDisplayed = false;
      }
      // Delete last digit
      else if (value == 'del') {
        if (_input.isNotEmpty && _input != '0') {
          _input = _input.substring(0, _input.length - 1);
          if (_input.isEmpty) _input = '0';
        }
        _output = _input;
      }
      // Add decimal point
      else if (value == '.') {
        if (!_input.contains('.')) {
          _input += '.';
          _output = _input;
        }
      }
      // Convert to percentage
      else if (value == '%') {
        double num = double.tryParse(_input) ?? 0;
        _input = (num / 100).toString();
        _output = _input;
      }
      // Calculate result
      else if (value == '=') {
        if (_operation != '0') {
          num2 = double.tryParse(_input) ?? 0;
          switch (_operation) {
            case '+':
              result = num1 + num2;
              _output = '$num1+$num2=$result';
              break;
            case '-':
              result = num1 - num2;
              _output = '$num1-$num2=$result';
              break;
            case '×':
              result = num1 * num2;
              _output = '$num1×$num2=$result';
              break;
            case '÷':
              if (num2 != 0) {
                result = num1 / num2;
                _output = '$num1÷$num2=$result';
              } else {
                _output = 'Error';
                return;
              }
              break;
          }
          _input = result.toString();
        } else {
          _output = _input;
        }

        // Reset state after calculation
        num1 = 0;
        num2 = 0;
        _operation = '0';
        _isResultDisplayed = true;
      }
      // Handle number input
      else {
        if (_isResultDisplayed) {
          _input = value;
          _output = _input;
          _isResultDisplayed = false;
        } else if (_input == '0') {
          _input = value;
          _output = _input;
        } else {
          _input += value;
          _output = _input;
        }

        // If there's an operation pending, show the full expression
        if (_operation != '0' && !_isResultDisplayed) {
          _output = '$num1$_operation$_input';
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(backgroundColor: Color(0xFF7fb4ec),elevation: 1,title: Text('Calculator', style: TextStyle(fontSize: 30))),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF7fb4ec), width: 4),
                ),
                color: Color(0xFFe1efff),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Text(_output, style: TextStyle(fontSize: 70)),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 20,
            width: 60,
            child: Divider(
              thickness: 5,
              color: Color(0xFFe1efff),
              radius: BorderRadius.circular(100),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OperatorButton(
                onclick: () => ButtonPress('AC'),
                Operator: 'AC',
                fontSize: 33,
                color: Color(0xFF7fb4ec),
              ),
              OperatorButton(
                onclick: () => ButtonPress('C'),
                Operator: 'C',
                fontSize: 35,
                color: Color(0xFF7fb4ec),
                fontweight: FontWeight.w600,
              ),
              OperatorButton(
                onclick: () => ButtonPress('%'),
                Operator: '%',
                fontSize: 40,
                color: Color(0xFF7fb4ec),
                fontweight: FontWeight.w800,
              ),
              OperatorButton(
                onclick: () => ButtonPress('÷'),
                Operator: '÷',
                fontSize: 52,
                color: Color(0xFF7fb4ec),
              ),
            ],
          ), //AC ( ) % ÷
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberButton(
                onclick: () => ButtonPress('1'),
                Number: '1',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('2'),
                Number: '2',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('3'),
                Number: '3',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              OperatorButton(
                onclick: () => ButtonPress('×'),
                Operator: '×',
                fontSize: 52,
                color: Color(0xFF7fb4ec),
              ),
            ],
          ), //1 2 3 ÷
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberButton(
                onclick: () => ButtonPress('4'),
                Number: '4',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('5'),
                Number: '5',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('6'),
                Number: '6',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              OperatorButton(
                onclick: () => ButtonPress('-'),
                Operator: '-',

                fontSize: 50,
                color: Color(0xFF7fb4ec),
              ),
            ],
          ), //4 5 6 -
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberButton(
                onclick: () => ButtonPress('7'),
                Number: '7',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('8'),
                Number: '8',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('9'),
                Number: '9',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              OperatorButton(
                onclick: () => ButtonPress('+'),
                Operator: '+',
                fontSize: 50,
                color: Color(0xFF7fb4ec),
              ),
            ],
          ), //7 8 9 +
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberButton(
                onclick: ()=>ButtonPress('.'),
                Number: '.',
                fontSize: 50,
                color: Color(0xFFe1effc),
              ),
              NumberButton(
                onclick: () => ButtonPress('0'),
                Number: '0',
                fontSize: 35,
                color: Color(0xFFe1effc),
              ),
              Icon_Button(
                onclick: () => ButtonPress('del'),
                color: Color(0xFFe1effc),
              ),
              OperatorButton(
                onclick: () => ButtonPress('='),
                Operator: '=',
                fontSize: 52,
                color: Color(0xFF7fb4ec),
              ),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
