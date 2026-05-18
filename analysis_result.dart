enum TargetDecision { reject, hold, candidate, targetBElite }
class AnalysisResult {
  final TargetDecision decision; final String classLabelAr; final double pScore, ipiScore, remoteConfidence, fieldConfidence, overallConfidence; final String reasonAr, fieldActionAr, gpzStrategyAr; final List<String> activeIndicators, warnings;
  const AnalysisResult({required this.decision,required this.classLabelAr,required this.pScore,required this.ipiScore,required this.remoteConfidence,required this.fieldConfidence,required this.overallConfidence,required this.reasonAr,required this.fieldActionAr,required this.gpzStrategyAr,required this.activeIndicators,required this.warnings});
}
