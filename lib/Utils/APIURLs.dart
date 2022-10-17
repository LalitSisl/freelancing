class APIUrls {
  static const String ADD_BUSINESS_DETAILS = "${BASE_URL}add_business_details";
  static const String ADD_Bank_DETAILS = "${BASE_URL}add_bank_details";
  static const String ADD_PERSONAL_DETAILS = "${BASE_URL}add_personal_details";
  static const String ADD_VENDOR_DETAILS = "${BASE_URL}add_vendor_details";
  static const String BASE_URL = "http://52.172.214.245/index.php/api/";

  static const String BASE_URL_IMAGE = "http://52.172.214.245/"; //Testing
  static const String DOMAIN = "52.172.214.245";
  static const String GET_BANK = "/index.php/api/bank_master";
  static const String GET_CITY = "/index.php/api/cities";
  static const String GET_EXPERIENCE = "/index.php/api/work_experience_master";
  static const String GET_QUALIFICATION = "/index.php/api/qualification_master";
  static const String GET_SKILLS = "/index.php/api/skills_master";
  static const String GET_STATE = "/index.php/api/states";
  static const String GET_USER_COMPLETE_DETAILS =
      "/index.php/api/user_complete_details";
  static const String GET_VENDOR_COMAPNY_TYPE =
      "/index.php/api/company_types_master";
  static const String LOG_IN = "${BASE_URL}send_otp";
  static const String OTP_RESEND = "${BASE_URL}resend_otp";
  static const String OTP_VERIFY = "${BASE_URL}verify_otp";
  static const String POST_IMAGES = "${BASE_URL}upload_files";
  static const String REGISTER_AS = "/index.php/api/user_details";
  static const String UPDATE_PERSONAL_DETAILS =
      "${BASE_URL}add_personal_details";
}
