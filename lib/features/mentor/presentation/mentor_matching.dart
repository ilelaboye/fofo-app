import 'package:flutter/material.dart';
import 'package:fofo_app/config/theme.dart';
import 'package:fofo_app/core/widgets/appbar.dart';
import 'package:fofo_app/core/widgets/gap.dart';
import 'package:fofo_app/core/widgets/section_header.dart';
import 'package:fofo_app/core/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MentorMatchingPage extends StatelessWidget {
  const MentorMatchingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Mentor Matching",
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            TextInputField(
              hintText: "Search names",
              prefix: const Icon(PhosphorIcons.magnifyingGlassBold),
            ),
            Gap.lg,
            const SectionHeader("Recommended")
          ],
        ),
      )),
    );
  }
}
