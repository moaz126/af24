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
  
  @override
  // TODO: implement ADDRESS
  String get ADDRESS => throw UnimplementedError();
  
  @override
  // TODO: implement ADD_IMAGES
  String get ADD_IMAGES => throw UnimplementedError();
  
  @override
  // TODO: implement ADD_MORE_COLOR
  String get ADD_MORE_COLOR => throw UnimplementedError();
  
  @override
  // TODO: implement ADD_MORE_SIZE
  String get ADD_MORE_SIZE => throw UnimplementedError();
  
  @override
  // TODO: implement ADD_NEW_SIZE
  String get ADD_NEW_SIZE => throw UnimplementedError();
  
  @override
  // TODO: implement ALLOW_BUY
  String get ALLOW_BUY => throw UnimplementedError();
  
  @override
  // TODO: implement ALL_ORDERS
  String get ALL_ORDERS => throw UnimplementedError();
  
  @override
  // TODO: implement ALREADY
  String get ALREADY => throw UnimplementedError();
  
  @override
  // TODO: implement BRANDS
  String get BRANDS => throw UnimplementedError();
  
  @override
  // TODO: implement CAMERA
  String get CAMERA => throw UnimplementedError();
  
  @override
  // TODO: implement CANCELLED
  String get CANCELLED => throw UnimplementedError();
  
  @override
  // TODO: implement CATEGORY
  String get CATEGORY => throw UnimplementedError();
  
  @override
  // TODO: implement CATTING_WITH
  String get CATTING_WITH => throw UnimplementedError();
  
  @override
  // TODO: implement COLOR
  String get COLOR => throw UnimplementedError();
  
  @override
  // TODO: implement COLOR_NAME
  String get COLOR_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement COMPANY
  String get COMPANY => throw UnimplementedError();
  
  @override
  // TODO: implement CONFIRMED
  String get CONFIRMED => throw UnimplementedError();
  
  @override
  // TODO: implement CONFIRM_PASS
  String get CONFIRM_PASS => throw UnimplementedError();
  
  @override
  // TODO: implement CONSUMER_PRICE
  String get CONSUMER_PRICE => throw UnimplementedError();
  
  @override
  // TODO: implement CONTACT
  String get CONTACT => throw UnimplementedError();
  
  @override
  // TODO: implement COUPON
  String get COUPON => throw UnimplementedError();
  
  @override
  // TODO: implement CUSTOMER_DETAIL
  String get CUSTOMER_DETAIL => throw UnimplementedError();
  
  @override
  // TODO: implement CUSTOMER_ID
  String get CUSTOMER_ID => throw UnimplementedError();
  
  @override
  // TODO: implement CUSTOMER_NAME
  String get CUSTOMER_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement DATE_OF_ORDER
  String get DATE_OF_ORDER => throw UnimplementedError();
  
  @override
  // TODO: implement DELETE
  String get DELETE => throw UnimplementedError();
  
  @override
  // TODO: implement DELIVERED
  String get DELIVERED => throw UnimplementedError();
  
  @override
  // TODO: implement DELIVERY_ID
  String get DELIVERY_ID => throw UnimplementedError();
  
  @override
  // TODO: implement DESCRIPTION
  String get DESCRIPTION => throw UnimplementedError();
  
  @override
  // TODO: implement DESC_HINT
  String get DESC_HINT => throw UnimplementedError();
  
  @override
  // TODO: implement DETAILS
  String get DETAILS => throw UnimplementedError();
  
  @override
  // TODO: implement DISCOUNT
  String get DISCOUNT => throw UnimplementedError();
  
  @override
  // TODO: implement EARNINGS
  String get EARNINGS => throw UnimplementedError();
  
  @override
  // TODO: implement EDIT
  String get EDIT => throw UnimplementedError();
  
  @override
  // TODO: implement EDIT_PAYMENT_LINKS
  String get EDIT_PAYMENT_LINKS => throw UnimplementedError();
  
  @override
  // TODO: implement EDIT_PRICE
  String get EDIT_PRICE => throw UnimplementedError();
  
  @override
  // TODO: implement EMAIL
  String get EMAIL => throw UnimplementedError();
  
  @override
  // TODO: implement EMAIL_SEND
  String get EMAIL_SEND => throw UnimplementedError();
  
  @override
  // TODO: implement ENTER_DELIV_ID
  String get ENTER_DELIV_ID => throw UnimplementedError();
  
  @override
  // TODO: implement ENTER_TRAK_ID
  String get ENTER_TRAK_ID => throw UnimplementedError();
  
  @override
  // TODO: implement FIRST_NAME
  String get FIRST_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement GALLERY
  String get GALLERY => throw UnimplementedError();
  
  @override
  // TODO: implement GENERATE_VARIANTS
  String get GENERATE_VARIANTS => throw UnimplementedError();
  
  @override
  // TODO: implement GRAND_TOTAL
  String get GRAND_TOTAL => throw UnimplementedError();
  
  @override
  // TODO: implement ISSUED
  String get ISSUED => throw UnimplementedError();
  
  @override
  // TODO: implement LAST_NAME
  String get LAST_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement LINK_NO
  String get LINK_NO => throw UnimplementedError();
  
  @override
  // TODO: implement METHOD
  String get METHOD => throw UnimplementedError();
  
  @override
  // TODO: implement MOBILE_NUMBER
  String get MOBILE_NUMBER => throw UnimplementedError();
  
  @override
  // TODO: implement MY_MESSAGES
  String get MY_MESSAGES => throw UnimplementedError();
  
  @override
  // TODO: implement MY_ORDER
  String get MY_ORDER => throw UnimplementedError();
  
  @override
  // TODO: implement MY_ORDERS
  String get MY_ORDERS => throw UnimplementedError();
  
  @override
  // TODO: implement MY_STORE
  String get MY_STORE => throw UnimplementedError();
  
  @override
  // TODO: implement NAME
  String get NAME => throw UnimplementedError();
  
  @override
  // TODO: implement NOTIFICATION
  String get NOTIFICATION => throw UnimplementedError();
  
  @override
  // TODO: implement NUMBER_HINT
  String get NUMBER_HINT => throw UnimplementedError();
  
  @override
  // TODO: implement ORDER
  String get ORDER => throw UnimplementedError();
  
  @override
  // TODO: implement ORDERS_DETAILS
  String get ORDERS_DETAILS => throw UnimplementedError();
  
  @override
  // TODO: implement ORDERS_NO
  String get ORDERS_NO => throw UnimplementedError();
  
  @override
  // TODO: implement ORDER_DETAIL
  String get ORDER_DETAIL => throw UnimplementedError();
  
  @override
  // TODO: implement ORDER_NO
  String get ORDER_NO => throw UnimplementedError();
  
  @override
  // TODO: implement ORDER_STATUS
  String get ORDER_STATUS => throw UnimplementedError();
  
  @override
  // TODO: implement PASSWORD
  String get PASSWORD => throw UnimplementedError();
  
  @override
  // TODO: implement PASSWORD_MSG
  String get PASSWORD_MSG => throw UnimplementedError();
  
  @override
  // TODO: implement PAYMENT_LINKS
  String get PAYMENT_LINKS => throw UnimplementedError();
  
  @override
  // TODO: implement PAYMENT_PAGE
  String get PAYMENT_PAGE => throw UnimplementedError();
  
  @override
  // TODO: implement PENDING
  String get PENDING => throw UnimplementedError();
  
  @override
  // TODO: implement PICK_COLOR
  String get PICK_COLOR => throw UnimplementedError();
  
  @override
  // TODO: implement PICK_IMAGE
  String get PICK_IMAGE => throw UnimplementedError();
  
  @override
  // TODO: implement PRICE
  String get PRICE => throw UnimplementedError();
  
  @override
  // TODO: implement PROCESSING
  String get PROCESSING => throw UnimplementedError();
  
  @override
  // TODO: implement PRODUCTS
  String get PRODUCTS => throw UnimplementedError();
  
  @override
  // TODO: implement PRODUCT_DETAIL
  String get PRODUCT_DETAIL => throw UnimplementedError();
  
  @override
  // TODO: implement PRODUCT_NAME
  String get PRODUCT_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement PYMENT_STATUS
  String get PYMENT_STATUS => throw UnimplementedError();
  
  @override
  // TODO: implement QUANTITY
  String get QUANTITY => throw UnimplementedError();
  
  @override
  // TODO: implement QUICK_ANSWER
  String get QUICK_ANSWER => throw UnimplementedError();
  
  @override
  // TODO: implement REGISTER
  String get REGISTER => throw UnimplementedError();
  
  @override
  // TODO: implement SAVE_DETAILS
  String get SAVE_DETAILS => throw UnimplementedError();
  
  @override
  // TODO: implement SEARCH_DATE
  String get SEARCH_DATE => throw UnimplementedError();
  
  @override
  // TODO: implement SELL
  String get SELL => throw UnimplementedError();
  
  @override
  // TODO: implement SHIPPING_COST
  String get SHIPPING_COST => throw UnimplementedError();
  
  @override
  // TODO: implement SHIPPING_FEE
  String get SHIPPING_FEE => throw UnimplementedError();
  
  @override
  // TODO: implement SHOP_ADDRESS
  String get SHOP_ADDRESS => throw UnimplementedError();
  
  @override
  // TODO: implement SHOP_NAME
  String get SHOP_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement SIZE
  String get SIZE => throw UnimplementedError();
  
  @override
  // TODO: implement SKU
  String get SKU => throw UnimplementedError();
  
  @override
  // TODO: implement STATUS
  String get STATUS => throw UnimplementedError();
  
  @override
  // TODO: implement SUB_CATEGORY
  String get SUB_CATEGORY => throw UnimplementedError();
  
  @override
  // TODO: implement SUB_NAME
  String get SUB_NAME => throw UnimplementedError();
  
  @override
  // TODO: implement SUB_TOTAL
  String get SUB_TOTAL => throw UnimplementedError();
  
  @override
  // TODO: implement TAX
  String get TAX => throw UnimplementedError();
  
  @override
  // TODO: implement TOTAL_AMOUNT
  String get TOTAL_AMOUNT => throw UnimplementedError();
  
  @override
  // TODO: implement TRAKING_ID
  String get TRAKING_ID => throw UnimplementedError();
  
  @override
  // TODO: implement UPDATE
  String get UPDATE => throw UnimplementedError();
  
  @override
  // TODO: implement UPLOAD_NOW
  String get UPLOAD_NOW => throw UnimplementedError();
  
  @override
  // TODO: implement UPLOAD_PRODUCT
  String get UPLOAD_PRODUCT => throw UnimplementedError();
  
  @override
  // TODO: implement VALIDATOR
  String get VALIDATOR => throw UnimplementedError();
  
  @override
  // TODO: implement VIEW_ALL
  String get VIEW_ALL => throw UnimplementedError();
  
  @override
  // TODO: implement WHOLESALE_PRICE
  String get WHOLESALE_PRICE => throw UnimplementedError();
  
  @override
  // TODO: implement WRITE_MESS
  String get WRITE_MESS => throw UnimplementedError();
  
  @override
  // TODO: implement REMEBER_ME
  String get REMEBER_ME => throw UnimplementedError();
  
  @override
  // TODO: implement EDIT_PROFILE
  String get EDIT_PROFILE => throw UnimplementedError();
  
  @override
  // TODO: implement NO_MESSAGES
  String get NO_MESSAGES => throw UnimplementedError();
  
  @override
  // TODO: implement NO_PRODUCTS
  String get NO_PRODUCTS => throw UnimplementedError();
  
  @override
  // TODO: implement ADD
  String get ADD => throw UnimplementedError();
  
  @override
  // TODO: implement NO_ORDERS
  String get NO_ORDERS => throw UnimplementedError();
  
  @override
  // TODO: implement COMMENT
  String get COMMENT => throw UnimplementedError();
  
  @override
  // TODO: implement NO_COMMENT
  String get NO_COMMENT => throw UnimplementedError();
  
  @override
  // TODO: implement NO_REQUEST
  String get NO_REQUEST => throw UnimplementedError();
  
  @override
  // TODO: implement PRODUCT_DETAIL_TITLE
  String get PRODUCT_DETAIL_TITLE => throw UnimplementedError();
  
  @override
  // TODO: implement REQUEST
  String get REQUEST => throw UnimplementedError();
  
  @override
  // TODO: implement LEAVE_COMMENT
  String get LEAVE_COMMENT => throw UnimplementedError();
  
  @override
  // TODO: implement EDIT_PRODUCT
  String get EDIT_PRODUCT => throw UnimplementedError();
  
  @override
  // TODO: implement EMPTY_LIST
  String get EMPTY_LIST => throw UnimplementedError();
  
  @override
  // TODO: implement NO_LINKS
  String get NO_LINKS => throw UnimplementedError();
  
  @override
  // TODO: implement ERROR
  String get ERROR => throw UnimplementedError();
  
  @override
  // TODO: implement SUCCESS
  String get SUCCESS => throw UnimplementedError();
  
  @override
  // TODO: implement EXIT
  String get EXIT => throw UnimplementedError();
  
  @override
  // TODO: implement LOGOUT_SUCCESS
  String get LOGOUT_SUCCESS => throw UnimplementedError();
  
  @override
  // TODO: implement LOGOUT_TEXT
  String get LOGOUT_TEXT => throw UnimplementedError();
  
  @override
  // TODO: implement ALREADY_SIZE
  String get ALREADY_SIZE => throw UnimplementedError();
  
  @override
  // TODO: implement MATCH_FOUND
  String get MATCH_FOUND => throw UnimplementedError();
  
  @override
  // TODO: implement ALREADY_COLOR
  String get ALREADY_COLOR => throw UnimplementedError();
  
  @override
  // TODO: implement UPDATE_SUCCESS
  String get UPDATE_SUCCESS => throw UnimplementedError();
  
  @override
  // TODO: implement DELETE_TEXT
  String get DELETE_TEXT => throw UnimplementedError();
  
  @override
  // TODO: implement CHANGE_STATUS
  String get CHANGE_STATUS => throw UnimplementedError();
  
  @override
  // TODO: implement SAVE_SUCCESS
  String get SAVE_SUCCESS => throw UnimplementedError();
  
  @override
  // TODO: implement STATUS_TEXT
  String get STATUS_TEXT => throw UnimplementedError();
  
  @override
  // TODO: implement PRODUCT_ADDED
  String get PRODUCT_ADDED => throw UnimplementedError();
  
  @override
  // TODO: implement ADD_CLR_SZ
  String get ADD_CLR_SZ => throw UnimplementedError();
  
  @override
  // TODO: implement ENTER_EMAIL
  String get ENTER_EMAIL => throw UnimplementedError();
  
  @override
  // TODO: implement PASS_ERROR
  String get PASS_ERROR => throw UnimplementedError();
  
  @override
  // TODO: implement PASS_NOMATCH
  String get PASS_NOMATCH => throw UnimplementedError();
  
  @override
  // TODO: implement UPLOAD_IMAGE
  String get UPLOAD_IMAGE => throw UnimplementedError();
  
  @override
  // TODO: implement VARIENT_MSG
  String get VARIENT_MSG => throw UnimplementedError();
  
  @override
  // TODO: implement SESSION_EXPIRE
  String get SESSION_EXPIRE => throw UnimplementedError();
  
  @override
  // TODO: implement STATUS_UPDATE
  String get STATUS_UPDATE => throw UnimplementedError();
  
  @override
  // TODO: implement CROPPER
  String get CROPPER => throw UnimplementedError();
  
  @override
  // TODO: implement CROP_IMAGE
  String get CROP_IMAGE => throw UnimplementedError();
}

