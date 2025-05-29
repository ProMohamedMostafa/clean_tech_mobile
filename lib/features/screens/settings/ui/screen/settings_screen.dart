import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/settings/ui/widgets/settings_body.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).botNavTitle4),
        ),
        body: SettingsBody());
  }
}
