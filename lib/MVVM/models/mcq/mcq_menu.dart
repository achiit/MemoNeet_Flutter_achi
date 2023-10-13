class McqMenu {
  final String text;
  const McqMenu({required this.text});
}

class McqMenuItems {
  static const List<McqMenu> items = [
    startAgain,
    searchQuestion,
    report,
  ];

  static const startAgain = McqMenu(text: "Start Again");
  static const searchQuestion = McqMenu(text: "Search Question");
  static const report = McqMenu(text: "Report");
}
