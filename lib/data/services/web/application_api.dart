import 'package:knownledga/data/repositories/core/configuration.dart';
import 'package:knownledga/data/services/base/application_api.dart';

class WebApplicationApi extends BaseApplicationApi {

  @override
  Future<KnownledgaConfiguration> loadConfiguration() async {
    await Future.delayed(const Duration(seconds: 1));
    KnownledgaConfiguration.instance = KnownledgaConfiguration.init();
    return KnownledgaConfiguration.instance as KnownledgaConfiguration;
  }

  @override
  saveConfiguration(KnownledgaConfiguration configuration) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}