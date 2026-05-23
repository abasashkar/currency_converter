import 'package:currency_app/common/widgets/fade_slide_in.dart';
import 'package:currency_app/feature/currency_converter/ui/components/converter_form_card.dart';
import 'package:currency_app/feature/currency_converter/ui/components/hero_header.dart';
import 'package:flutter/material.dart';

class SuccessScrollContent extends StatelessWidget {
  const SuccessScrollContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FadeSlideIn(child: HeroHeader()),
          const SizedBox(height: 28),
          const FadeSlideIn(
            delay: Duration(milliseconds: 80),
            child: ConverterFormCard(),
          ),
        ],
      ),
    );
  }
}
