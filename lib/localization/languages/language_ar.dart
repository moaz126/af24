// ignore_for_file: non_constant_identifier_names
import 'languages.dart';

class LanguageAr extends Languages {

  //general
  @override
  String get NO_ADDS_FOUND => "لم يتم العثور على أي اعلانات";
  @override
  String get NO_NOTIFICATIONS => "لا يوجد اشعارات";
  @override
  String get SAVE => "حفظ";
  @override
  String get SEND => "أرسل";
  @override
  String get SUBMIT => "ارسال";
  @override
  String get ALL => "الكل";
  @override
  String get OK => "موافق";
  @override
  String get ZERO_SAR => "0 ريال";
  @override
  String get SAR => "ريال";
  @override
  String get TO => "إلى";

  //welcome
  @override
  String get APP_NAME => 'جحا';
  @override
  String get WELCOME => "مرحبا";
  @override
  String get LOGIN => "تسجيل دخول";
  @override
  String get SIGNUP => "اشترك الان";

  //login
  @override
  String get PHONE_HINT => "رقم الهاتف";
  @override
  String get PASS_HINT => "كلمة المرور";
  @override
  String get FORGOT_PASSWORD => "'نسيت كلمة المرور";
  @override
  String get NO_ACCOUNT => "لايوجد لدي حسا ";

  //forgot/reset password
  @override
  String get EMAIL_VERIFICATION_TEXT => "أدخل بريدك الالكتروني للحصول على رابط تفعيل الحساب على بريدك الإلكتروني";
  @override
  String get RESET_PASSWORD => "إعادة تعيين كلمة المرور";
  @override
  String get VERIFICATION_CODE_HINT => "رمز التحقق";
  @override
  String get NEW_PASS_HINT => "'أدخل كلمة مرور جديدة";
  @override
  String get CONFIRM_PASS_HINT => "تأكيد كلمة المرور";
  @override
  String get PASSWORD_MISMATCH => "كلمة المرور غير مطابقة";
  @override
  String get CODE_MISMATCH => "الرمز غير مطابق";

  //signup
  @override
  String get NAME_HINT => 'الاسم';
  @override
  String get EMAIL_HINT => "البريد الالكتروني";
  @override
  String get GENDER => 'الجنس';
  @override
  String get MALE => 'ذكر';
  @override
  String get FEMALE => 'أنثى';
  @override
  String get AGE => "العمر";
  @override
  String get COUNTRY => "الدولة";
  @override
  String get SELECT_COUNTRY => "اختيار الدولة";
  @override
  String get CITY => "المدينة";
  @override
  String get SELECT_CITY => "اختيار المدينة";
  @override
  String get AREA => "المنطقة";
  @override
  String get SELECT_AREA => "اختيار المنطقة";
  @override
  String get ZONE => "منطقة";
  @override
  String get SELECT_ZONE => "اختيار الحي";
  @override
  String get TERMS_CONDITIONS => "الشروط والأحكام";
  @override
  String get VERIFICATION_CODE_SENT => "تم ارسال رمز التحقق إلى بريدك الالكتروني";
  @override
  String get AGREE_TERMS => "نرجو الموافقة على' الشروط والأحكام";
  @override
  String get ALREADY_ACCOUNT => "'هل لديك حساب؟ ";
  @override
  String get INVALID_NAME => "مطلوب الأسم";
  @override
  String get INVALID_EMAIL => "مطلوب البريد الإلكتروني";
  @override
  String get INVALID_AGE => "مطلوب العمر";
  @override
  String get INVALID_PASSWORD => "مطلوب كلمة المرور";
  @override
  String get PASSWORD_LENGTH => "كلمة المرور' يجب أن تحتوي على ٨ خانات";
  @override
  String get INVALID_PHONE => "مطلوب رقم الهاتف";
  @override
  String get INVALID_MOBILE_NUMBER => "رقم الجوال غير صالح";
  @override
  String get REQUIRED => "هذه الخانة مطلوبه";
  @override
  String get SKIP => "يتخطى";
  @override
  String get UNDER => "تحت";
  @override
  String get ABOVE => "في الاعلى";
  @override
  String get PLEASE_WAIT => "أرجو الإنتظار";

  //OTP
  @override
  String get VERIFICATION => "التحقق";
  @override
  String get ENTER_OTP => "أدخل كلمة المرور المؤقتة";
  @override
  String get VERIFY => "تحقق";
  @override
  String get NO_OTP => "لم يتم استلام الرمز?";
  @override
  String get RESEND_CODE => "اعادة ارسال الرمز";

  //bottom navigation
  @override
  String get YES => "نعم";
  @override
  String get NO => "لا";
  @override
  String get EXIT_APP_TEXT => "هل أنت متأكد من أنك’ تريد الخروج من التطبيق";
  @override
  String get HOME => "إعلان مباشر";
  @override
  String get ARCHIVE => "أعلانات اخر ٢٤ ساعة";
  @override
  String get WINNERS => "الفائزين";
  @override
  String get PROFILE => "الملف الشخصي";
  @override
  String get WISHLIST => "المفضلة";


  //drawer
  @override
  String get DASHBOARD => "صفحة المعلومات";
  @override
  String get NOTIFICATIONS => "الإشعارات";
  @override
  String get PRIVACY_POLICY => "سياسة الخصوصية";
  @override
  String get ABOUT_US => "من نحن";
  @override
  String get LOGOUT => "تسجيل خروج";

  //winners page
  @override
  String get NO_WINNERS_FOUND => "لم يتم العثور على فائزين";
  @override
  String get GROUP => "المجموعة: ";
  @override
  String get WINNING_DATE => "تاريخ الفوز: ";
  @override
  String get SELECT_DATE => "حدد تاريخ";
  @override
  String get ALL_WINNERS => "كل الفائزين";
  @override
  String get PRIZE_MONEY => "القيمة: ";

  //profile page
  @override
  String get PROFILE_UPDATED => "تم تحديث الملف الشخصي بنجاح";

  //dashboard
  @override
  String get TOTAL_APP_DOWNLOADS => "متابعون";
  @override
  String get TODAY_LOTTERY_VALUE => "السحب التالي";
  @override
  String get TODAY_LOTTERY_PRIZE => "قيمة السحوبات القادمة";
  @override
  String get NUMBER_OF_WINNERS => "# الفائزين";
  @override
  String get VALUE => " القيمة، ريال";
  @override
  String get NO_LOTTERY => "لم يتم الإعلان عن قرعة الحظ حتى الآن";
}

