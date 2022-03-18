import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/offer.dart';
import '../entities/product.dart';

abstract class DataRepository {
  Future<Either<Failure, List<Offer>>> getOffers();

  Future<Either<Failure, List<Product>>> getProducts();
}
