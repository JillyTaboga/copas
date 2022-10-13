enum CardValue {
  two('2', 1),
  three('3', 2),
  four('4', 3),
  five('5', 4),
  six('6', 5),
  seven('7', 6),
  eigh('8', 7),
  nine('9', 8),
  ten('10', 9),
  jack('J', 10),
  queen('Q', 11),
  king('K', 12),
  as('A', 13);

  final String label;
  final int value;

  const CardValue(this.label, this.value);
}
