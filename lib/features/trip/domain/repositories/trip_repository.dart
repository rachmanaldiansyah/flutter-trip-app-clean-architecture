import 'package:dartz/dartz.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';

import '../../../../cores/exception/failure_exception.dart';

abstract class TripRepository {
  Future<Either<Failure, List<TripEntity>>> getTrip();
  Future<void> addTrip(TripEntity trip);
  Future<void> deleteTrip(int index);
}
