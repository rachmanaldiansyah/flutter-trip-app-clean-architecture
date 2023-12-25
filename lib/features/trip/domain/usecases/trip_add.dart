import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(TripEntity trip) {
    return repository.addTrip(trip);
  }
}
