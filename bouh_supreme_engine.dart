import '../core/constants/thresholds.dart';
import '../domain/models/grid_cell.dart';
import '../domain/models/analysis_result.dart';
import 'target_b_engine.dart';
import 'gpz_engine.dart';
class BouhSupremeEngine {
  static AnalysisResult analyze(GridCell c){
    final active=<String>[]; final warnings=<String>[];
    if(c.structureScore>0.55) active.add('بنية/قص'); if(c.patternScore>0.55) active.add('نمط/تجمع'); if(c.claySwirIndex>0.55) active.add('Clay/SWIR'); if(c.ironIndex>0.55) active.add('Iron'); if(c.quartzSilicaIndex>0.55) active.add('Quartz/Silica'); if(c.twiScore>0.55||c.drainageScore>0.55) active.add('Terrain/Drainage'); if(c.fieldEvidenceScore>0.50) active.add('Field Evidence');
    if(c.structureScore<=BouhThresholds.noStructureReject) return _report(TargetDecision.reject,'مرفوض',c,'رفض فوري: لا توجد بنية جيولوجية كافية. No Structure = Reject.','لا تنزل ميدانيًا لهذه النقطة إلا إذا ظهرت شواهد جديدة.',active,['غياب البنية الحاضنة']);
    if(c.patternScore<=BouhThresholds.noPatternReject) return _report(TargetDecision.reject,'مرفوض',c,'رفض: لا يوجد نمط مكاني أو تجمع مؤشرات واضح. No Pattern = Reject.','استبعد النقطة أو اتركها كمرجع ضوضاء.',active,['غياب النمط/التجمع']);
    if(c.claySwirIndex<=BouhThresholds.noClayHold) return _report(TargetDecision.hold,'قيد الانتظار',c,'تعليق: لا توجد إشارة Clay/SWIR كافية. لا ترفع الهدف إلى Target-B.','تحقق ميدانيًا من الكوارتز والتماس قبل أي حفر.',active,['ضعف Clay/SWIR']);
    if(c.noiseProbability>BouhThresholds.highNoiseHold) return _report(TargetDecision.hold,'قيد الانتظار',c,'تعليق: احتمالية ضجيج سطحية مرتفعة.','افحص بصريًا واعزل laterite/barite noise قبل القرار.',active,['احتمال ضجيج لاتيريت/باريت مرتفع']);
    if(active.length<3) warnings.add('أقل من 3 مؤشرات نشطة داخل النطاق');
    final ipi=TargetBEngine.ipi(c);
    if(ipi>=BouhThresholds.targetB && active.length>=3) return _report(TargetDecision.targetBElite,'هدف Target-B ممتاز',c,'تقاطع قوي بين البنية والتحوير والنمط. الهدف صالح كأولوية ميدانية عالية مع تأكيد عينات.','تحقق ميداني مركز: صور، GPZ، عينات vein + wall rock، ثم assay/QA-QC.',active,warnings);
    if(ipi>=BouhThresholds.candidate) return _report(TargetDecision.candidate,'مرشح قوي',c,'مؤشرات جيدة لكنها تحتاج رفع الثقة عبر الميدان أو الجيوكيمياء.','نفّذ مسارًا ميدانيًا قصيرًا وخندق اختبار عند التماس أو التقاطع.',active,warnings);
    return _report(TargetDecision.hold,'قيد المراجعة',c,'النقطة ليست مرفوضة نهائيًا لكنها دون عتبة Target-B.','اجعلها ضمن مسح إقليمي ولا تبدأ حفرًا مباشرًا.',active,warnings);
  }
  static AnalysisResult _report(TargetDecision d,String label,GridCell c,String reason,String action,List<String> active,List<String> warnings){ final p=TargetBEngine.pScore(c); final ipi=TargetBEngine.ipi(c); final remote=(1.0-c.uncertainty).clamp(0.0,1.0).toDouble(); final field=c.fieldEvidenceScore.clamp(0.0,1.0).toDouble(); final overall=((remote*0.7)+(field*0.3)-(c.noiseProbability*0.15)).clamp(0.0,1.0).toDouble(); return AnalysisResult(decision:d,classLabelAr:label,pScore:p,ipiScore:ipi,remoteConfidence:double.parse(remote.toStringAsFixed(2)),fieldConfidence:double.parse(field.toStringAsFixed(2)),overallConfidence:double.parse(overall.toStringAsFixed(2)),reasonAr:reason,fieldActionAr:action,gpzStrategyAr:GpzEngine.strategy(magneticGroundRisk:c.magneticGroundRisk,quartzScore:c.quartzSilicaIndex,ironScore:c.ironIndex),activeIndicators:active,warnings:warnings); }
}
