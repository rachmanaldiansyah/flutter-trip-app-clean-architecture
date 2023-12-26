import 'package:dartz/dartz.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

import '../../../../cores/exception/failure_exception.dart';

class GetTrip {
  final TripRepository repository;

  GetTrip(this.repository);

  Future<Either<Failure, List<TripEntity>>> call() {
    return repository.getTrip();
  }
}
