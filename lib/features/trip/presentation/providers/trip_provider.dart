import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:travel_app_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:travel_app_clean_architecture/features/trip/data/models/trip_model.dart';
import 'package:travel_app_clean_architecture/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/entities/trip_entity.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/repositories/trip_repository.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/trip_add.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/trip_delete.dart';
import 'package:travel_app_clean_architecture/features/trip/domain/usecases/trip_get.dart';

final tripLocalDatasourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox: tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDatasourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final getTripProvider = Provider<GetTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrip(repository);
});

final deleteTripProvider = Provider<DeleteTrip>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<TripEntity>>((ref) {
  final getTrip = ref.read(getTripProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrip, addTrip, deleteTrip);
});

class TripListNotifier extends StateNotifier<List<TripEntity>> {
  final GetTrip _getTrip;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrip, this._addTrip, this._deleteTrip) : super([]);

  Future<void> addNewTrip(TripEntity trip) async {
    await _addTrip(trip);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip(tripId);
  }

  Future<void> loadTrip() async {
    final tripOrFailure = await _getTrip();
    tripOrFailure.fold((error) => state = [], (trip) => state = trip);
  }
}
