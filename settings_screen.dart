import 'package:flutter/material.dart'; import '../../core/constants/app_identity.dart';
class SettingsScreen extends StatelessWidget{const SettingsScreen({super.key}); @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:const [Text('الإعدادات والهوية',style:TextStyle(fontSize:22,color:Color(0xFFD4AF37),fontWeight:FontWeight.bold)),SizedBox(height:12),Card(color:Color(0xFF101A14),child:Padding(padding:EdgeInsets.all(14),child:Text('اسم التطبيق: ${AppIdentity.appNameAr}
النسخة: ${AppIdentity.version}
المطور: ${AppIdentity.developerAr}

الوضع الحالي: Region Pack مدمج + خرائط حقيقية Online + محركات تحليل Offline.

المرحلة التالية: MBTiles Offline وCamera/TFLite وKML Export كامل.')))]);}
