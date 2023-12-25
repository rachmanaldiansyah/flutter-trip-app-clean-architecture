import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_clean_architecture/features/trip/data/models/trip_model.dart';

class TripLocalDataSource {
  final Box<TripModel> tripBox;

  TripLocalDataSource({required this.tripBox});

  List<TripModel> getTrip() {
    return tripBox.values.toList();
  }

  void addTrip(TripModel trip) {
    tripBox.add(trip);
  }

  void deleteTrip(int index) {
    tripBox.deleteAt(index);
  }
}
