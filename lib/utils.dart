// Returns list containing the best available distance and list of distances to cities to reach it
// chooseBestCities(174, 3, [51, 56, 58, 59, 61]) // [173, [59, 58, 56]]
// chooseBestCities(163, 3, [50]) // [-1, []]
List chooseBestCities(int distanceLimit, int numberOfCities, List<int> distances) {

  // check if count of distances is not less than count of cities to visit
  if(numberOfCities > distances.length) {
    return [-1, []];
  }

  List<int> list = List.of(distances);

  // if count of cities to visit equals 1, return the maximum element not greater than distance limit
  if (numberOfCities == 1){
    int sum = -1;
    for (int element in list) {
      if (element > sum && element <= distanceLimit){
        sum = element;
      }
    }
    return [sum, [sum]];
  }

  // initialize variables
  int sum = -1;
  List<int> cities = [];

  // fix each element and try to find the solution for reduced number of cities, reduced distance limit and
  // reduced list of distances
  for (int i = 0; i < list.length; i++){
    List<int> newList = List.of(list)..removeAt(i);
    List result = chooseBestCities(distanceLimit - list[i], numberOfCities - 1, newList);

    // if got better solution, change appropriate variables
    if (result[0] > -1 && result[0] + list[i] > sum) {
      sum = result[0] + list[i];
      cities = result[1] + [list[i]];
    }
  }

  return [sum, cities];
}