enum TheoryQuestionCategory {
  signs,
  safety,
  mechanics,
  unknown;

  static TheoryQuestionCategory fromApi(String? raw) {
    switch (raw?.trim().toUpperCase()) {
      case 'SIGNS':
        return TheoryQuestionCategory.signs;
      case 'SAFETY':
        return TheoryQuestionCategory.safety;
      case 'MECHANICS':
        return TheoryQuestionCategory.mechanics;
      default:
        return TheoryQuestionCategory.unknown;
    }
  }
}

enum TheoryCorrectOption {
  a,
  b,
  c,
  d;

  String get apiValue => name.toUpperCase();

  static TheoryCorrectOption? fromApi(String? raw) {
    switch (raw?.trim().toUpperCase()) {
      case 'A':
        return TheoryCorrectOption.a;
      case 'B':
        return TheoryCorrectOption.b;
      case 'C':
        return TheoryCorrectOption.c;
      case 'D':
        return TheoryCorrectOption.d;
      default:
        return null;
    }
  }
}

class TheoryQuestionEntity {
  const TheoryQuestionEntity({
    required this.id,
    required this.category,
    required this.questionText,
    required this.optionA,
    required this.optionB,
    required this.correctOption,
    this.imageUrl,
    this.optionC,
    this.optionD,
    this.explanation,
  });

  final int id;
  final TheoryQuestionCategory category;
  final String questionText;
  final String? imageUrl;
  final String optionA;
  final String optionB;
  final String? optionC;
  final String? optionD;
  final TheoryCorrectOption correctOption;
  final String? explanation;

  List<({TheoryCorrectOption option, String text})> get options {
    return [
      (option: TheoryCorrectOption.a, text: optionA),
      (option: TheoryCorrectOption.b, text: optionB),
      if (optionC != null && optionC!.trim().isNotEmpty)
        (option: TheoryCorrectOption.c, text: optionC!),
      if (optionD != null && optionD!.trim().isNotEmpty)
        (option: TheoryCorrectOption.d, text: optionD!),
    ];
  }
}
