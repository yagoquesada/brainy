import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_v3/src/app/chat_generator/providers/memory_provider.dart';

class MemorySwitch extends StatefulWidget {
  const MemorySwitch({Key? key}) : super(key: key);

  @override
  State<MemorySwitch> createState() => _MemorySwitchState();
}

class _MemorySwitchState extends State<MemorySwitch> {
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<MemoryProvider>(context, listen: false);

    return Switch.adaptive(
      activeColor: Colors.white,
      activeTrackColor: Colors.black26,
      splashRadius: 50.0,
      value: modelsProvider.hasMemory,
      onChanged: (value) => setState(
        () => modelsProvider.setMemoryEnabled(value),
      ),
    );
  }
}
