import 'package:al_nawaras/model/profile_model.dart';
import 'package:al_nawaras/services/profile_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = Rxn<ProfileModel>();
  final ProfileService service = ProfileService();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      update();
      final box = GetStorage();
      String token = box.read('token');
      final result = await service.fetchProfile(token);
      if (result != null) {
        profile.value = result;
      }
    } catch (e) {
      throw Exception("Error $e");
    } finally {
      isLoading(false);
      update();
    }
  }
}
