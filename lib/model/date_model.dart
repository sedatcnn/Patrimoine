class DateModel {
  late String gunler_;
  late String tarih_;
  bool isCurrentDay = false;
}

class TimeModel {
  final int saat;
  final String saatFormati;

  const TimeModel({required this.saat, required this.saatFormati});
}
