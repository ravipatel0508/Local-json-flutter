class Data {
  final String stateName;
  final int activeCases;
  final int newCases;
  final int recovered;
  final int deaths;
  final int totalCases;

  Data(
      {required this.stateName,
      required this.activeCases,
      required this.newCases,
      required this.recovered,
      required this.deaths,
      required this.totalCases});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      stateName: json['region'],
      activeCases: json['activeCases'],
      newCases: json['newInfected'],
      recovered: json['recovered'],
      deaths: json['deceased'],
      totalCases: json['totalInfected'],
    );
  }
}
