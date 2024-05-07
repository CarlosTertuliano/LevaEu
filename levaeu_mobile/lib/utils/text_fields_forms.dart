import "package:flutter/material.dart";

enum ValidationType {
  notEmpty,
  name,
  email,
  password,
  phone,
  zipcode,
  address,
  emailOrPhone,
}

class TextFieldsForms {

  static Widget buildTextFormField(String label, TextInputType inputType, TextEditingController controller, bool pass, ValidationType validationType, void Function(String?)? onSaved ) {

    String? Function(String?)? validator;
    switch (validationType) {
      case ValidationType.notEmpty:
        validator = validateNotEmpty;
        break;
      case ValidationType.name:
        validator = validateName;
        break;
      case ValidationType.email:
        validator = validateEmail;
        break;
      case ValidationType.password:
        validator = validatePassword;
        break;
      case ValidationType.phone:
        validator = validatePhone;
        break;
      case ValidationType.zipcode:
        validator = validateZipcode;
        break;
      case ValidationType.address:
        validator = validateAddress;
        break;
      case ValidationType.emailOrPhone:
        validator = validateEmailOrPhone;
        break;
    }

    return TextFormField (
      controller: controller,
      obscureText: pass,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1)),
        border: const UnderlineInputBorder(),
      ),
      style: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1), fontSize: 12.0),
      keyboardType: inputType,
      onSaved: onSaved,
    );

  }

  static void saveFormFieldValue(String? value) {
    print('Valor do campo salvo: $value');
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo abaixo.';
    }
    return null;
  }

  static String? validateName(String? value) {
    final nameRegex = RegExp(r'^(?! )[a-zA-Z ]{3,}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome.';
    } 
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor, insira um nome válido.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um email.';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, insira um email válido.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha.';
    }

    if (value.length < 8) {
      return 'A senha deve ter no minimo 8 caracteres';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final phoneRegex = RegExp(r'^[0-9]{2} [0-9]{5}-[0-9]{4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número de telefone';
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Por favor, insira um telefone no formato: xx 9xxxx-xxxx.';
    }

    return null;
  }

  static String? validateZipcode(String? value) {
    final zipCodeRegex = RegExp(r'^[0-9]{5}-[0-9]{3}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu número CEP';
    }

    if (!zipCodeRegex.hasMatch(value)) {
      return 'Por favor, insira um CEP válido, no formato: xxxxx-xxx.';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    final addressRegex = RegExp(r'^(?! )[a-zA-Z 0-9]{3,}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu endereço';
    }
    if(!addressRegex.hasMatch(value)){
      return 'Por favor, insira um endereço válido';
    }

    return null;
  }

  static String? validateEmailOrPhone(String? value){
    final phoneRegex = RegExp(r'^[0-9]{2} [0-9]{5}-[0-9]{4}$');
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'Por favor, preencha o campo';
    }

    if (!phoneRegex.hasMatch(value) && !emailRegex.hasMatch(value)) {
      return 'Por favor, insira seu email ou telefone';
    }

    return null;
  }
}