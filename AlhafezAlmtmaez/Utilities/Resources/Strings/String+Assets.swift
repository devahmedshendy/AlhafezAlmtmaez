//
//  String+Assets.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import Foundation

extension String {
    enum text {
        static var SignIn: String { "تسجيل الدخول" }
        static var PhoneNumber: String { "رقم الهاتف" }
        static var VerifyCode: String { "رمز التحقق" }
        static var VerifyCodeHeader: String { "الرجاء إدخال رمز التحقق" }
        static var VerifyCodeSentTo: String { "تم إرسال رمز التحقق إلى رقم الهاتف" }
        static var Verify: String { "تحقق" }
        static var ChangePhoneNumberQuestion: String { "هل تريد تغير رقم الهاتف؟" }

        // Tabs
        static var Home: String { "الصفحة الرئيسية" }
        static var Heros: String { "ابطال شاوس" }
        static var Quran: String { "قرآن" }
        static var MyAccount: String { "حسابى" }
        static var PersonalPage: String { "الصفحة الشخصية" }
    }

    enum alert {
        static var OK: String { "حسنا" }
        static var Cancel: String { "إلغاء" }

        static var ExpiredSessionTitle: String { "انتهت الجلسة" }
        static var ExpiredSessionDescription: String {
            "تم انتهاء الجلسة الحالية، برجاء تسجيل الدخول مرة أخرى"
        }
    }

    enum validation {
        static var phoneNumber: String { .httpBody.phone_number }
        static var verifyCode: String { .httpBody.code }
    }

    enum error {
        static var Unknown: String { "خطأ غير معروف، من فضلك تواصل مع الادمن" }
        static var AppSettings: String { "حدث خطأ فى الإعدادات، يرجى المحاولة مرة اخرى" }
        static var Serialization: String { "حدث خطأ فى معالجة البيانات" }
        static var MissingResponseData: String { "لم يتم الحصول على اى بيانات من السرفر" }
        static var FormValidation: String { "يرجى مراجعة الإخطاء وإعداة المحاولة" }
    }
}
