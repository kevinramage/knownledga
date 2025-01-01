import 'package:knownledga/data/repositories/core/configuration.dart';
import 'package:knownledga/data/services/base/log_api.dart';

abstract class BaseApplicationApi {

  late BaseLogApi log;

  /*
   * All interfaces
   */
  Future<KnownledgaConfiguration> loadConfiguration();
  saveConfiguration(KnownledgaConfiguration configuration);
}