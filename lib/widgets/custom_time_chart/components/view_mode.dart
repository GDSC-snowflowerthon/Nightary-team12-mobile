enum ViewMode {
  weekly(8),
  monthly(31);

  const ViewMode(this.dayCount);

  /// The count of blocks in the x-axis direction.
  final int dayCount;
}
