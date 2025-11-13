enum DynamicPricingStatus {
  ON,
  OFF;

  bool get isActive => this == DynamicPricingStatus.ON;
}