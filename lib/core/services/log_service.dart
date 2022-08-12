import 'package:dartz/dartz.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';

import '../../data/models/error_model.dart';
import '../../domain/repositories/data_repository.dart';
import '../../injection_container.dart';
import '../platform/app_info.dart';
import '../platform/network_info.dart';

class LogService {
  Future<void> logError(ErrorModel errorModel) async {
    if (await locator<NetworkInfo>().isConnected) {
      String error = '********************* \n Start of error\n';

      error += 'App info:\n ${AppInfo.version}+${AppInfo.buildNumber}\n';
      error += '++++++++++++++++++++++\n';
      error += 'Mobile info:\n ${AppInfo.mobileInfo}\n';
      error += '++++++++++++++++++++++\n';
      error +=
          'User info:\n ${locator<LocalDataRepository>().getUser().toJson()}\n';
      error += '----------------------\n';
      error += errorModel.toJson().toString();
      error += '----------------------\n';

      error += '********************* \n End of error';
      final result = locator<DataRepository>().sendMail(
        '${locator<LocalDataRepository>().getUser().name} & ${locator<LocalDataRepository>().getUser().userid}',
        locator<LocalDataRepository>().getUser().alogin ?? 'Not logged',
        error,
        true,
      );
      if (result is Right) {
        //
      } else {
        locator<LocalDataRepository>().logError(errorModel);
      }
    } else {
      locator<LocalDataRepository>().logError(errorModel);
    }
  }
}
