import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPaymentMethodBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onPaymentMethodAdded;

  const AddPaymentMethodBottomSheet({
    super.key,
    required this.onPaymentMethodAdded,
  });

  static Future<void> show(BuildContext context, Function(Map<String, dynamic>) onPaymentMethodAdded) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddPaymentMethodBottomSheet(
          onPaymentMethodAdded: onPaymentMethodAdded,
        ),
      ),
    );
  }

  @override
  State<AddPaymentMethodBottomSheet> createState() => _AddPaymentMethodBottomSheetState();
}

class _AddPaymentMethodBottomSheetState extends State<AddPaymentMethodBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  String _selectedCardType = 'Visa';
  bool _saveAsDefault = false;
  bool _isLoading = false;

  final List<String> _cardTypes = ['Visa', 'Mastercard', 'American Express', 'Discover'];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _savePaymentMethod() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create new payment method object
      final newPaymentMethod = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': _selectedCardType,
        'cardNumber': _formatCardNumberForDisplay(_cardNumberController.text),
        'cardHolder': _cardHolderController.text,
        'expiryDate': _expiryDateController.text,
        'isDefault': _saveAsDefault,
      };

      // Simulate a brief loading period
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          // Call the callback with the new payment method
          widget.onPaymentMethodAdded(newPaymentMethod);
          
          // Close the bottom sheet
          Navigator.pop(context);
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add payment method: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  String _formatCardNumberForDisplay(String cardNumber) {
    // Remove all non-digit characters
    final digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    
    // Keep only last 4 digits visible, mask the rest
    if (digitsOnly.length > 4) {
      final lastFour = digitsOnly.substring(digitsOnly.length - 4);
      return '**** **** **** $lastFour';
    }
    
    return digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight * 0.7,
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Payment Method',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Form
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Type Selection
                  Text(
                    'Card Type',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  _buildCardTypeSelector(theme),
                  
                  const SizedBox(height: 16),
                  
                  // Card Number
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      _CreditCardInputFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the card number';
                      }
                      // Remove spaces for validation
                      final digitsOnly = value.replaceAll(' ', '');
                      if (digitsOnly.length < 16) {
                        return 'Please enter a valid card number';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card Holder Name
                  TextFormField(
                    controller: _cardHolderController,
                    decoration: InputDecoration(
                      labelText: 'Card Holder Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the card holder name';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Expiry Date and CVV in a row
                  Row(
                    children: [
                      // Expiry Date Field
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            labelText: 'Expiry (MM/YY)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            _ExpiryDateInputFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (value.length < 5) {
                              return 'Invalid format';
                            }
                            return null;
                          },
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // CVV Field
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.security),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            if (value.length < 3) {
                              return 'Invalid CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Save as default option
                  SwitchListTile(
                    title: Text(
                      'Set as default payment method',
                      style: theme.textTheme.bodyLarge,
                    ),
                    value: _saveAsDefault,
                    onChanged: (value) {
                      setState(() {
                        _saveAsDefault = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                    activeColor: theme.colorScheme.primary,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _savePaymentMethod,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.onPrimary,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Add Card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

  Widget _buildCardTypeSelector(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: _selectedCardType,
        isExpanded: true,
        underline: Container(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedCardType = newValue;
            });
          }
        },
        items: _cardTypes.map<DropdownMenuItem<String>>((String value) {
          IconData iconData;
          switch (value) {
            case 'Visa':
              iconData = Icons.credit_card;
              break;
            case 'Mastercard':
              iconData = Icons.credit_card;
              break;
            case 'American Express':
              iconData = Icons.credit_card;
              break;
            case 'Discover':
              iconData = Icons.credit_card;
              break;
            default:
              iconData = Icons.credit_card;
          }

          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(iconData, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(value),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Custom input formatter for credit card formatting (adds spaces)
class _CreditCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only format if text is being added, not removed
    if (newValue.text.length <= oldValue.text.length) {
      return newValue;
    }
    
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }
    
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

// Custom input formatter for expiry date (MM/YY format)
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    if (newValue.text.length <= oldValue.text.length) {
      return newValue;
    }
    
    if (text.length >= 3 && !text.contains('/')) {
      final formattedText = '${text.substring(0, 2)}/${text.substring(2)}';
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    
    // Limit to MM/YY format (5 chars)
    if (text.length > 5) {
      return oldValue;
    }
    
    return newValue;
  }
}