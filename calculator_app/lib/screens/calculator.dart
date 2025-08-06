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
  String _input = '0';
  String _operation = '0';
  double num1 = 0;
  double num2 = 0;
  double result = 0;
  bool _isResultDisplayed = false;

  /// Converts a number to a string while removing unnecessary decimal places
  String formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  /// Handles all button presses
  void ButtonPress(String value) {
    setState(() {
      switch (value) {
        // Reset everything to default
        case 'AC':
          _input = '0';
          _operation = '0';
          num1 = 0;
          num2 = 0;
          _isResultDisplayed = false;
          break;

        // Clear only the current input
        case 'C':
          _input = '0';
          break;

        // If an operator is pressed
        case '+':
        case '-':
        case '×':
        case '÷':
          if (_operation != '0' && !_isResultDisplayed) {
            // Perform the previous operation first
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
                  _input = 'Error';
                  _operation = '0';
                  _isResultDisplayed = true;
                  return;
                }
                break;
            }
          } else if (!_isResultDisplayed) {
            // Store first number if no operation is ongoing
            num1 = double.tryParse(_input) ?? 0;
          }

          // Prepare for the next input
          _input = '0';
          _operation = value;
          _isResultDisplayed = false;
          break;

        // Handle deletion of the last character
        case 'del':
          if (_input.isNotEmpty && _input != '0') {
            _input = _input.substring(0, _input.length - 1);
            if (_input.isEmpty || _input == '-') {
              _input = '0';
            }
          }
          break;

        // Add a decimal point
        case '.':
          if (!_input.contains('.')) {
            _input += '.';
          }
          break;

        // Convert the input to a percentage
        case '%':
          double number = double.tryParse(_input) ?? 0;
          _input = (number / 100).toString();
          break;

        // Calculate the final result
        case '=':
          if (_operation != '0') {
            num2 = double.tryParse(_input) ?? 0;
            switch (_operation) {
              case '+':
                result = num1 + num2;
                break;
              case '-':
                result = num1 - num2;
                break;
              case '×':
                result = num1 * num2;
                break;
              case '÷':
                if (num2 != 0) {
                  result = num1 / num2;
                } else {
                  _input = 'Error';
                  _operation = '0';
                  _isResultDisplayed = true;
                  return;
                }
                break;
            }

            // Format and display result
            String formattedResult = result
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
            String formattedNum1 = formatNumber(num1);
            String formattedNum2 = formatNumber(num2);

            _operation = '$formattedNum1$_operation$formattedNum2=';
            _input = formattedResult;
          }

          // Prepare for new input if needed
          num1 = result;
          num2 = 0;
          _isResultDisplayed = true;
          break;

        // If number is pressed
        default:
          if (_input.length >= 9 &&
              !_isResultDisplayed &&
              !_input.contains('.')) {
            return;
          }

          if (_isResultDisplayed || _input == '0') {
            _input = value;
          } else {
            _input += value;
          }

          _isResultDisplayed = false;

          // If input follows a previous result, reset operation
          if (_operation.contains('=')) {
            _operation = '0';
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7fb4ec),
        elevation: 1,
        title: Text('Calculator', style: TextStyle(fontSize: 30)),
      ),
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _operation != '0'
                          ? _operation.contains('=')
                                ? _operation
                                : '${formatNumber(num1)}$_operation'
                          : '',
                      style: TextStyle(fontSize: 40, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Text(
                      _input,
                      style: TextStyle(fontSize: 70),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 20,
            width: 60,
            child: Divider(thickness: 5, color: Color(0xFFe1efff)),
          ),
          buildButtonRows(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  /// Builds all calculator buttons grouped in rows
  Widget buildButtonRows() {
    return Column(
      children: [
        buildRow(
          [
            () => ButtonPress('AC'),
            () => ButtonPress('C'),
            () => ButtonPress('%'),
            () => ButtonPress('÷'),
          ],
          ['AC', 'C', '%', '÷'],
          [33, 35, 40, 52],
        ),
        buildRow(
          [
            () => ButtonPress('1'),
            () => ButtonPress('2'),
            () => ButtonPress('3'),
            () => ButtonPress('×'),
          ],
          ['1', '2', '3', '×'],
          [35, 35, 35, 52],
        ),
        buildRow(
          [
            () => ButtonPress('4'),
            () => ButtonPress('5'),
            () => ButtonPress('6'),
            () => ButtonPress('-'),
          ],
          ['4', '5', '6', '-'],
          [35, 35, 35, 50],
        ),
        buildRow(
          [
            () => ButtonPress('7'),
            () => ButtonPress('8'),
            () => ButtonPress('9'),
            () => ButtonPress('+'),
          ],
          ['7', '8', '9', '+'],
          [35, 35, 35, 50],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberButton(
              onclick: () => ButtonPress('.'),
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
      ],
    );
  }

  /// Utility to simplify row construction
  Widget buildRow(
    List<VoidCallback> callbacks,
    List<String> labels,
    List<double> fontSizes,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        final isOperator = [
          'AC',
          'C',
          '%',
          '÷',
          '×',
          '-',
          '+',
        ].contains(labels[index]);
        return isOperator
            ? OperatorButton(
                onclick: callbacks[index],
                Operator: labels[index],
                fontSize: fontSizes[index],
                color: Color(0xFF7fb4ec),
              )
            : NumberButton(
                onclick: callbacks[index],
                Number: labels[index],
                fontSize: fontSizes[index],
                color: Color(0xFFe1effc),
              );
      }),
    );
  }
}
