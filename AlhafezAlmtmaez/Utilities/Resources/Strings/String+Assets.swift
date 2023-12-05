//
//  String+Assets.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 30/11/2023.
//

import Foundation

extension String {
    enum text {
        static var signin: String { "تسجيل الدخول" }
        static var phoneNumber: String { "رقم الهاتف" }
    }

    enum error {
        static var unknown: String { "خطأ غير معروف، من فضلك تواصل مع الادمن" }
        static var appSettings: String { "حدث خطأ فى الإعدادات، يرجى المحاولة مرة اخرى" }
        static var serialization: String { "حدث خطأ فى معالجة البيانات" }
        static var unexpectedResponseData: String { "رد غير متوقع من السرفر" }
    }
}
