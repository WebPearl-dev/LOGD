class ForestEventData {
  final String id;
  final String titleKey;
  final String descKey;

  const ForestEventData({
    required this.id,
    required this.titleKey,
    required this.descKey,
  });
}

// Centrale lijst van alle losse tekstverhalen in het bos!
const List<ForestEventData> forestEventsList = [
  ForestEventData(id: "fountain", titleKey: "eventFountainTitle", descKey: "eventFountainDesc"),
  ForestEventData(id: "giant", titleKey: "eventGiantTitle", descKey: "eventGiantDesc"),
  ForestEventData(id: "hermit", titleKey: "eventHermitTitle", descKey: "eventHermitDesc"), // De Kluizenaar!
];
