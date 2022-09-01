import 'package:rest_api_package/requests/rest_api_request.dart';

class GetCardsRequest extends IRestApiRequest {
  GetCardsRequest() {
    endPoint = 'home/getCampaigns';
    requestMethod = RequestMethod.GET;
  }
}
