

import 'package:get/get.dart';

class ImageDetailController extends GetxController {


  late String image_url;
  late String display_sitename;
  late String datetime;



  @override
  void onInit() async {
    print("ImageDetailController ---------------------------- onInit()");
    /// Getx 로 부터 넘어온 파라미터 추출
    image_url = Get.parameters['image_url'] ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE1BFq0h-RvrEBWCMPudD2QMYcG2BDJVDYNw&usqp=CAU";
    display_sitename = Get.parameters['display_sitename'] ?? "";
    datetime = Get.parameters['datetime'] ?? "";

    print('image_url : $image_url');
    print('display_sitename : $display_sitename');
    print('datetime : $datetime');


    super.onInit();
  }
  @override
  void onClose() {
    print("ImageDetailController ---------------------------- onClose()");
    super.onClose();
  }


}