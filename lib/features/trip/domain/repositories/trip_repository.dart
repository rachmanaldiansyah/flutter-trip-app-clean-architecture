import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';

abstract class TripRepository {
  Future<List<TripEntity>> getTrip();
  Future<void> addTrip(TripEntity trip);
  Future<void> deleteTrip(int index);
}
