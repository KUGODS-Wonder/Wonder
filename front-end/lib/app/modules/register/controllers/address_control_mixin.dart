import 'package:get/get.dart';

mixin AddressControlMixin on GetxController {
  final selectedAddressItem = "강동구".obs;
  final listType = [
    '강동구',
    '송파구',
    '강남구',
    '서초구',
    '관악구',
    '동작구',
    '금천구',
    '영등포구',
    '구로구',
    '양천구',
    '강서구',
    '은평구',
    '마포구',
    '서대문구',
    '종로구',
    '용산구',
    '중구',
    '성동구',
    '동대문구',
    '성북구',
    '강북구',
    '도봉구',
    '노원구',
    '중랑구',
    '광진구'
  ];

  void setSelected(String value) {
    selectedAddressItem.value = value;
  }
}
