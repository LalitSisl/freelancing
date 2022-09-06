class APIUrls {
  static const String BASE_URL =
      "http://52.172.214.245/sisl-swan/index.php/api/"; //Testing
  static const String DOMAIN = "52.172.214.245";
  static const String LOG_IN = "${BASE_URL}send_otp";
  static const String OTP_VERIFY = "${BASE_URL}verify_otp";
  static const String OTP_RESEND = "${BASE_URL}resend_otp";
  static const String ADD_PERSONAL_DETAILS = "${BASE_URL}add_personal_details";
}
