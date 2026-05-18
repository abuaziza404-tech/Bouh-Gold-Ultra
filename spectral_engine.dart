class SpectralEngine {
  static double ironIndex({required double red, required double blue}) => red / (blue + 1e-6);
  static double quartzIndex({required double swir1, required double swir2}) => swir1 / (swir2 + 1e-6);
  static double alterationIndex({required double swir1, required double swir2, required double nir}) => (swir1 + swir2) / (nir + 1e-6);
  static Map<String,double> sentinel2({required double b2,required double b4,required double b8,required double b11,required double b12})=>{'iron':ironIndex(red:b4,blue:b2),'quartz':quartzIndex(swir1:b11,swir2:b12),'alteration':alterationIndex(swir1:b11,swir2:b12,nir:b8),'ndmi':(b8-b11)/(b8+b11+1e-6)};
}
