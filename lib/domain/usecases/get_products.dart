import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase_without_param.dart';
import '../entities/product.dart';
import '../repositories/data_repository.dart';

class GetProducts implements UseCaseWithOutParam<List<Product>> {
  final DataRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
