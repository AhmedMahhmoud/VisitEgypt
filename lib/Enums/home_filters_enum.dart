enum HomeFilterType {
  allPlaces(0),
  bestRated(1),
  byLocation(2);

  const HomeFilterType(this.value);

  final int value;
}
