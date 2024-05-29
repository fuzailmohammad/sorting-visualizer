import 'package:get/get.dart';
import 'package:sorting_visualizer/app/data/network/network_requester.dart';

class BaseRepository {
  NetworkRequester get controller => GetInstance().find<NetworkRequester>();
}
