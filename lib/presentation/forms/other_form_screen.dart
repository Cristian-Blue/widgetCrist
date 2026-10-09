import 'package:contador/config/theme/app_theme.dart';
import 'package:contador/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherFormScreen extends ConsumerStatefulWidget {
  const OtherFormScreen({super.key});

  @override
  ConsumerState<OtherFormScreen> createState() => _OtherFormScreenState();
}

class _OtherFormScreenState extends ConsumerState<OtherFormScreen> {
  int? valor;

  // Estado local: Checkboxes
  bool _guitar = false;
  bool _piano = false;
  bool _drums = false;
  bool _violin = false;

  String _selectedGenre = "";

  @override
  Widget build(BuildContext context) {
    final colorSelect = ref.watch(colorProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Other form')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(label: Text('Valor')),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Valor 1')),
                    DropdownMenuItem(value: 2, child: Text('Valor 2')),
                    DropdownMenuItem(value: 3, child: Text('Valor 3')),
                    DropdownMenuItem(value: 4, child: Text('Valor 4')),
                  ],
                  onChanged: (value) {},
                  onSaved: (newValue) {
                    valor = newValue ?? 0;
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(label: Text('Valor')),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Valor 1')),
                    DropdownMenuItem(value: 2, child: Text('Valor 2')),
                    DropdownMenuItem(value: 3, child: Text('Valor 3')),
                    DropdownMenuItem(value: 4, child: Text('Valor 4')),
                  ],
                  onChanged: (_) {},
                  onSaved: (newValue) {
                    valor = newValue ?? 0;
                  },
                ),
                RadioGroup(
                  groupValue: _selectedGenre,
                  onChanged: (String? value) {
                    setState(() => _selectedGenre = value!);
                  },
                  child: const Column(
                    children: [
                      RadioListTile<String>(
                        title: Text("Rock"),
                        value: "Rock",
                        controlAffinity: ListTileControlAffinity.platform,
                      ),
                      RadioListTile<String>(title: Text("Pop"), value: "Pop"),
                      RadioListTile<String>(title: Text("Jazz"), value: "Jazz"),
                    ],
                  ),
                ),
                CheckboxListTile(
                  title: const Text("Guitarra"),
                  value: _guitar,
                  onChanged: (val) => setState(() => _guitar = val!),
                ),
                CheckboxListTile(
                  title: const Text("Piano"),
                  value: _piano,
                  onChanged: (val) => setState(() => _piano = val!),
                ),
                CheckboxListTile(
                  title: const Text("Batería"),
                  value: _drums,
                  onChanged: (val) => setState(() => _drums = val!),
                ),
                CheckboxListTile(
                  title: const Text("Violín"),
                  value: _violin,
                  onChanged: (val) => setState(() => _violin = val!),
                ),
                RadioGroup(
                  groupValue: colorSelect,
                  onChanged: (value) => setState(() {
                    ref.read(colorProvider.notifier).changeColor(value ?? 0);
                  }),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: colorList.length,
                        itemBuilder: (context, index) {
                          return RadioListTile<int>(
                            title: Text('Color ${index + 1}'),
                            value: index,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            visualDensity: const VisualDensity(vertical: -3),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
