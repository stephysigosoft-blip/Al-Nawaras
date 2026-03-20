import 'package:al_nawaras/model/profile_model.dart';
import 'package:al_nawaras/services/profile_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profile = Rxn<ProfileModel>();
  final ProfileService service = ProfileService();

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    try {
      isLoading(true);
      final box = GetStorage();
      String? token = box.read('token'); 

      if (token != null) {
        final result = await service.fetchProfile(token); 
        if (result != null) {
          profile.value = result;
        }
      }
    } catch (e) {
      Get.snackbar("Error",e.toString(),snackPosition:SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
      update();
    }
  }
}