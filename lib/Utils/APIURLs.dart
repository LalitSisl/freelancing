class APIUrls {
  static const String BASE_URL =
      "http://52.172.214.245/sisl-swan/index.php/api/";
  static const String BASE_URL_IMAGE  = "http://52.172.214.245/sisl-swan/";//Testing
  static const String DOMAIN = "52.172.214.245";
  static const String LOG_IN = "${BASE_URL}send_otp";
  static const String OTP_VERIFY = "${BASE_URL}verify_otp";
  static const String POST_IMAGES = "${BASE_URL}upload_files";
  static const String ADD_VENDOR_DETAILS = "${BASE_URL}add_vendor_details";
  static const String REGISTER_AS = "/sisl-swan/index.php/api/user_details";
  static const String GET_USER_COMPLETE_DETAILS = "/sisl-swan/index.php/api/user_complete_details";
  static const String GET_QUALIFICATION = "/sisl-swan/index.php/api/qualification_master";
  static const String GET_SKILLS = "/sisl-swan/index.php/api/skills_master";
  static const String GET_CITY = "/sisl-swan/index.php/api/cities";
  static const String GET_STATE = "/sisl-swan/index.php/api/states";
  static const String GET_BANK = "/sisl-swan/index.php/api/bank_master";
  static const String GET_EXPERIENCE = "/sisl-swan/index.php/api/work_experience_master";
  static const String GET_VENDOR_COMAPNY_TYPE = "/sisl-swan/index.php/api/company_types_master";

  static const String OTP_RESEND = "${BASE_URL}resend_otp";
  static const String ADD_PERSONAL_DETAILS = "${BASE_URL}add_personal_details";
   static const String UPDATE_PERSONAL_DETAILS = "${BASE_URL}add_personal_details";
  static const String ADD_BUSINESS_DETAILS = "${BASE_URL}add_business_details";
  static const String ADD_Bank_DETAILS = "${BASE_URL}add_bank_details";

}
