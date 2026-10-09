import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String name = '';
  final TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forms')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(label: Text('Nombre')),
                ),
                SizedBox(height: 10),
                Text('Data: $name'),
                SizedBox(height: 10),
                TextField(
                  controller: lastName,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(label: Text('LastName')),
                ),
                Text('LastName ${lastName.text}'),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      name = '';
                      lastName.clear();
                    });
                  },
                  child: Text('Clear'),
                ),
                _FormCustom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormCustom extends StatefulWidget {
  const _FormCustom({super.key});

  @override
  State<_FormCustom> createState() => __FormCustomState();
}

class __FormCustomState extends State<_FormCustom> {
  final _formController = GlobalKey<FormState>();
  String phone = '';
  String mail = '';
  String description = '';
  int son = 0;
  String music = '';

  final List<String> optionsType = ["Rock", "Pop", "Balada", "Jazz"];

  void send() {
    if (!_formController.currentState!.validate()) {
      print('error');
      return;
    }
    _formController.currentState!.save();
    print(phone);
    print(mail);
    print(description);
    print(son);
    print(music);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formController,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(label: Text('Telefono')),
            onSaved: (newValue) => phone = newValue ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone is required';
              }

              return null;
            },
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(label: Text('Correo')),
            onSaved: (newValue) => mail = newValue ?? '',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El correo es obligatorio';
              }

              final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

              if (!emailRegex.hasMatch(value)) {
                return 'Ingrese un correo válido';
              }

              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 4,
            decoration: InputDecoration(label: Text('Description')),
            onSaved: (newValue) => description = newValue ?? '',
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Numbers son')),
            onSaved: (newValue) => son = int.tryParse(newValue ?? '') ?? 0,
          ),
          DropdownButtonFormField<String>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hint: Text('Seleccione'),
            items: optionsType
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (_) => {},
            validator: (value) => value == null ? 'field required' : null,

            onSaved: (newValue) => music = newValue ?? '',
            decoration: const InputDecoration(labelText: "Tipo de canción"),
          ),
          FilledButton(onPressed: send, child: Text('Enviar')),
        ],
      ),
    );
  }
}
