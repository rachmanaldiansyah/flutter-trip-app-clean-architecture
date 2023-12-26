import 'package:dartz/dartz.dart';
import 'package:travel_app_clean_architecture/cores/exception/failure_exception.dart';
import 'package:travel_app_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_clean_architecture/features/trip/data/models/trip_model.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource localDatasource;

  TripRepositoryImpl(this.localDatasource);

  @override
  Future<void> addTrip(TripEntity trip) async {
    final tripModel = TripModel.fromEntity(trip);
    localDatasource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async {
    localDatasource.deleteTrip(index);
  }

  @override
  Future<Either<Failure, List<TripEntity>>> getTrip() async {
    try {
      final tripModel = localDatasource.getTrip();
      List<TripEntity> res =
          tripModel.map((model) => model.toEntity()).toList();
      return Right(res);
    } catch (err) {
      return Left(SomeSpecificError(err.toString()));
    }
  }
}
