import 'dart:math';
import 'package:flutter/material.dart';
import '../theme.dart';

class KalculatorPage extends StatefulWidget {
  const KalculatorPage({super.key});

  @override
  State<KalculatorPage> createState() => _KalculatorPageState();
}

class _KalculatorPageState extends State<KalculatorPage> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _shouldClearOnNextDigit = false;

  void _onButtonPressed(String label) {
    if ('0123456789'.contains(label)) {
      _inputDigit(label);
    } else if (label == '.') {
      _inputDecimalPoint();
    } else if (['+', '-', '×', '÷'].contains(label)) {
      _setOperator(label);
    } else if (label == '=') {
      _calculateResult();
    } else if (label == 'Hapus') {
      _backspace(); // backspace satu digit
    } else if (label == 'x²') {
      _square();
    } else if (label == '√x') {
      _squareRoot();
    }
  }

  void _inputDigit(String digit) {
    setState(() {
      if (_shouldClearOnNextDigit || _display == '0' || _display == 'Error') {
        _display = digit;
        _shouldClearOnNextDigit = false;
      } else {
        _display += digit;
      }
    });
  }

  void _inputDecimalPoint() {
    setState(() {
      if (_shouldClearOnNextDigit || _display == 'Error') {
        _display = '0.';
        _shouldClearOnNextDigit = false;
      } else if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _setOperator(String op) {
    final currentValue = double.tryParse(_display);
    if (currentValue == null) {
      _showError();
      return;
    }

    setState(() {
      if (_firstOperand != null && _operator != null && !_shouldClearOnNextDigit) {
        final result =
            _performOperation(_firstOperand!, currentValue, _operator!);
        if (result == null) {
          _showError();
        } else {
          _firstOperand = result;
          _display = _formatResult(result);
        }
      } else {
        _firstOperand = currentValue;
      }
      _operator = op;
      _shouldClearOnNextDigit = true;
    });
  }

  void _calculateResult() {
    if (_firstOperand == null || _operator == null) return;

    final secondValue = double.tryParse(_display);
    if (secondValue == null) {
      _showError();
      return;
    }

    final result =
        _performOperation(_firstOperand!, secondValue, _operator!);
    setState(() {
      if (result == null) {
        _display = 'Error';
      } else {
        _display = _formatResult(result);
      }
      _firstOperand = null;
      _operator = null;
      _shouldClearOnNextDigit = true;
    });
  }

  double? _performOperation(double a, double b, String op) {
    switch (op) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '×':
        return a * b;
      case '÷':
        if (b == 0) return null;
        return a / b;
      default:
        return null;
    }
  }

  void _square() {
    final value = double.tryParse(_display);
    if (value == null) return _showError();
    setState(() {
      final result = value * value;
      _display = _formatResult(result);
      _firstOperand = null;
      _operator = null;
      _shouldClearOnNextDigit = true;
    });
  }

  void _squareRoot() {
    final value = double.tryParse(_display);
    if (value == null || value < 0) return _showError();
    setState(() {
      final result = sqrt(value);
      _display = _formatResult(result);
      _firstOperand = null;
      _operator = null;
      _shouldClearOnNextDigit = true;
    });
  }

  // hapus satu digit (backspace)
  void _backspace() {
    setState(() {
      if (_display == 'Error') {
        _display = '0';
        _firstOperand = null;
        _operator = null;
        _shouldClearOnNextDigit = false;
        return;
      }

      if (_shouldClearOnNextDigit) {
        _display = '0';
        _firstOperand = null;
        _operator = null;
        _shouldClearOnNextDigit = false;
        return;
      }

      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
        if (_display == '-' || _display.isEmpty) {
          _display = '0';
        }
      }
    });
  }

  void _showError() {
    setState(() {
      _display = 'Error';
      _firstOperand = null;
      _operator = null;
      _shouldClearOnNextDigit = true;
    });
  }

  String _formatResult(double value) {
    if (value % 1 == 0) return value.toInt().toString();
    return value.toString();
  }

  String _buildExpressionText() {
    if (_firstOperand == null || _operator == null) return '';
    final firstText = _formatResult(_firstOperand!);
    return _shouldClearOnNextDigit
        ? '$firstText $_operator'
        : '$firstText $_operator $_display';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ======= HEADER / DISPLAY =======
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.pink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_buildExpressionText().isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        _buildExpressionText(),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _display,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ],
              ),
            ),
          ),

          // ======= TOMBOL =======
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  Expanded(
                    child: _buildRow(['Hapus', 'x²', '√x', '÷'],
                        [true, false, false, true]),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildRow(
                        ['7', '8', '9', '×'], [false, false, false, true]),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildRow(
                        ['4', '5', '6', '-'], [false, false, false, true]),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildRow(
                        ['1', '2', '3', '+'], [false, false, false, true]),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildLastRow(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // helper row builder
  Widget _buildRow(List<String> labels, List<bool> operatorFlags) {
    return Row(
      children: List.generate(labels.length, (i) {
        final label = labels[i];
        final isOperator = operatorFlags[i];
        final isAccent = label == 'Hapus';
        final isFunction = ['x²', '√x'].contains(label);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _CalcButton(
              label: label,
              isOperator: isOperator,
              isAccent: isAccent,
              isFunction: isFunction,
              onTap: () => _onButtonPressed(label),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLastRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _CalcButton(
              label: '0',
              onTap: () => _onButtonPressed('0'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _CalcButton(
              label: '.',
              onTap: () => _onButtonPressed('.'),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _CalcButton(
              label: '=',
              isEquals: true,
              onTap: () => _onButtonPressed('='),
            ),
          ),
        ),
      ],
    );
  }
}

// ======= TOMBOL CUSTOM =======
class _CalcButton extends StatelessWidget {
  final String label;
  final bool isOperator;
  final bool isEquals;
  final bool isAccent;
  final bool isFunction;
  final VoidCallback onTap;

  const _CalcButton({
    required this.label,
    required this.onTap,
    this.isOperator = false,
    this.isEquals = false,
    this.isAccent = false,
    this.isFunction = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    if (isEquals) {
      bg = AppColors.primary;
      fg = Colors.white;
    } else if (isOperator) {
      bg = AppColors.yellow;
      fg = Colors.white;
    } else if (isAccent) {
      bg = AppColors.pink;
      fg = Colors.white;
    } else if (isFunction) {
      bg = Colors.white;
      fg = AppColors.primary;
    } else {
      bg = Colors.white;
      fg = Colors.black87;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87, 
            ).copyWith(color: fg),
          ),
        ),
      ),
    );
  }
}
