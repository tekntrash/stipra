import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase_without_param.dart';
import '../entities/offer.dart';
import '../repositories/data_repository.dart';

class GetOffers implements UseCaseWithOutParam<List<Offer>> {
  final DataRepository repository;

  GetOffers(this.repository);

  @override
  Future<Either<Failure, List<Offer>>> call() async {
    return await repository.getOffers();
  }
}
