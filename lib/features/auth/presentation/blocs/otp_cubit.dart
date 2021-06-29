import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/injection.dart';

class OtpCubit extends Cubit<String> {
  OtpCubit() : super(null);

  final sharePref = getIt<SharedPreferences>();

  validateOtp(String otp) async {
    final finalOtp = sharePref.getString(FORGOT_PASSWORD_OTP);
    print(finalOtp);

    if (otp != null && otp.length == 6 && finalOtp == otp) {
      emit(otp);
    }
  }
}
